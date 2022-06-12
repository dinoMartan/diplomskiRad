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
    private let authenticationRepository: AuthenticationRepositoryProtocol

    init(keychainService: KeychainServiceProtocol, authenticationRepository: AuthenticationRepositoryProtocol) {
        self.keychainService = keychainService
        self.authenticationRepository = authenticationRepository
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
            presenter?.interactor(didFailLogin: Login.LoginAction.Response.Failure(myError: myError))
            return
        }
        authenticationRepository.signInUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authenticationResponse):
                self?.keychainService.setUserLoggedIn(true)
                self?.keychainService.setUserId(authenticationResponse.userId)
                self?.presenter?.interactor(didSucceedLogin: Login.LoginAction.Response.Success())
            case .failure(let myError):
                self?.presenter?.interactor(didFailLogin: Login.LoginAction.Response.Failure(myError: myError))
            }
        }
    }

    func forgottenPassword(request: Login.ForgottenPasswordAction.Request) {
        guard let email = request.email,
              !email.isEmpty
        else {
            let myError = MyError(type: .passwordResetFailed, message: nil)
            presenter?.interactor(didFailForgottenPassword: Login.ForgottenPasswordAction.Response.Failure(myError: myError))
            return
        }
        authenticationRepository.sendResetPasswordEmail(email: email) { [weak self] result in
            switch result {
            case .success(_):
                self?.presenter?.interactor(didSucceedForgottenPassword: Login.ForgottenPasswordAction.Response.Success())
            case .failure(let myError):
                self?.presenter?.interactor(didFailForgottenPassword: Login.ForgottenPasswordAction.Response.Failure(myError: myError))
            }
        }
    }
}
