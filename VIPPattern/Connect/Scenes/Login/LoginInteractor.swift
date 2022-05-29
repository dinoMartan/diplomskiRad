//
//  LoginInteractor.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func loginUser(request: Login.LoginAction.Request)
    func forgottenPassword(request: Login.ForgottenPasswordAction.Request)
}

class LoginInteractor: LoginInteractorProtocol {
    var presenter: LoginPresenterProtocol?

    private let keychainService: KeychainServiceProtocol
    private let authenticationService: AuthenticationServiceProtocol

    init(keychainService: KeychainServiceProtocol, authenticationService: AuthenticationServiceProtocol) {
        self.keychainService = keychainService
        self.authenticationService = authenticationService
    }

    deinit {
        print("deinit \(self)")
    }
}

extension LoginInteractor {
    func loginUser(request: Login.LoginAction.Request) {
        guard let email = request.email,
              !email.isEmpty,
              let password = request.password,
              !password.isEmpty
        else {
            let myError = MyError(type: .registrationFieldsRequired, message: nil)
            presenter?.interactor(didFail: Login.ResponseFailure(myError: myError))
            return
        }
        authenticationService.signInUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authDataResult):
                self?.keychainService.setUserLoggedIn(true)
                self?.keychainService.setUserId(authDataResult.user.uid)
                self?.presenter?.interactor(didSucceedLogin: Login.LoginAction.ResponseSuccess())
            case .failure(let myError):
                self?.presenter?.interactor(didFail: Login.ResponseFailure(myError: myError))
            }
        }
    }

    func forgottenPassword(request: Login.ForgottenPasswordAction.Request) {
        guard let email = request.email,
              !email.isEmpty
        else {
            let myError = MyError(type: .passwordResetFailed, message: nil)
            presenter?.interactor(didFail: Login.ResponseFailure(myError: myError))
            return
        }
        authenticationService.sendResetPasswordEmail(email: email) { [weak self] result in
            switch result {
            case .success(_):
                self?.presenter?.interactor(didSucceedForgottenPassword: Login.ForgottenPasswordAction.ResponseSuccess())
            case .failure(let myError):
                self?.presenter?.interactor(didFail: Login.ResponseFailure(myError: myError))
            }
        }
    }
}