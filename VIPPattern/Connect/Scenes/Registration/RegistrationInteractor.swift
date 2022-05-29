//
//  RegistrationInteractor.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation
import UIKit

protocol RegistrationInteractorProtocol {
    func registerUser(username: String?, firstName: String?, lastName: String?, email: String?, password: String?, image: UIImage?)
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
    func registerUser(username: String?, firstName: String?, lastName: String?, email: String?, password: String?, image: UIImage?) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty,
              let username = username, !username.isEmpty,
              let firstName = firstName, !firstName.isEmpty,
              let lastName = lastName, !lastName.isEmpty
        else {
            let myError = MyError(type: .registrationFieldsRequired, message: nil)
            presenter?.interactor(didFail: myError)
            return
        }
        var user = User(id: nil,
                        username: username,
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        profileImage: nil)
        authenticationService.registerUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authDataResult):
                user.id = authDataResult.user.uid
                self?.addUserToDatabase(user: user, image: image)
                self?.keychainService.setUserLoggedIn(true)
                self?.keychainService.setUserId(authDataResult.user.uid)
                self?.presenter?.interactorDidSucceedRegistration()
            case .failure(let myError):
                self?.presenter?.interactor(didFail: myError)
            }
        }
    }

    private func addUserToDatabase(user: User, image: UIImage?) {
        userRepository.setUser(user: user, userImage: image) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let myError):
                self?.presenter?.interactor(didFail: myError)
            }
        }
    }
}
