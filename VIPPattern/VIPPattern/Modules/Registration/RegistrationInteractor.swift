//
//  RegistrationInteractor.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol RegistrationInteractorProtocol {
    func registerUser(email: String?, password: String?)
}

class RegistrationInteractor: RegistrationInteractorProtocol {
    var presenter: RegistrationPresenterProtocol?

    private let authenticationService: AuthenticationServiceProtocol
    private let keychainService: KeychainServiceProtocol
    private let userRepository: UserRepositoryProtocol

    init(keychainService: KeychainServiceProtocol, authenticationService: AuthenticationServiceProtocol, userRepository: UserRepositoryProtocol) {
        self.keychainService = keychainService
        self.authenticationService = authenticationService
        self.userRepository = userRepository
    }

    deinit {
        print("deinit \(self)")
    }
}

extension RegistrationInteractor {
    func registerUser(email: String?, password: String?) {
        guard let email = email,
        !email.isEmpty,
        let password = password,
        !password.isEmpty
        else {
            let myError = MyError(type: .emailOrPasswordFieldEmpty, message: nil)
            presenter?.interactor(didFail: myError)
            return
        }
        authenticationService.registerUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authDataResult):
                self?.addUserToDatabase(userId: authDataResult.user.uid)
                self?.keychainService.setUserLoggedIn(true)
                self?.keychainService.setUserId(authDataResult.user.uid)
                self?.presenter?.interactorDidSucceedRegistration()
            case .failure(let myError):
                self?.presenter?.interactor(didFail: myError)
            }
        }
    }

    private func addUserToDatabase(userId: String) {
        let user = User(id: userId)
        userRepository.setUser(user: user) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let myError):
                self?.presenter?.interactor(didFail: myError)
            }
        }
    }
}
