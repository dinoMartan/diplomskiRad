//
//  LoginInteractor.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func loginUser(email: String?, password: String?)
    func sendResetPasswordEmail(email: String?)
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
    func loginUser(email: String?, password: String?) {
        guard let email = email,
        !email.isEmpty,
        let password = password,
        !password.isEmpty
        else {
            let myError = MyError(type: .emailOrPasswordFieldEmpty, message: nil)
            presenter?.interactor(didFail: myError)
            return
        }
        authenticationService.signInUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.keychainService.setUserLoggedIn(true)
                self?.presenter?.interactorDidSuceedLogin()
            case .failure(let myError):
                self?.presenter?.interactor(didFail: myError)
            }
        }
    }

    func sendResetPasswordEmail(email: String?) {
        guard let email = email,
        !email.isEmpty
        else {
            let myError = MyError(type: .passwordResetFailed, message: nil)
            presenter?.interactor(didFail: myError)
            return
        }
        authenticationService.sendResetPasswordEmail(email: email) { [weak self] result in
            switch result {
            case .success(_):
                self?.presenter?.interactorDidSucceedSendForgottenPasswordEmail()
            case .failure(let myError):
                self?.presenter?.interactor(didFail: myError)
            }
        }
    }
}
