//
//  RegistrationInteractor.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation
import UIKit

protocol RegistrationInteractorProtocol {
    func registerUser(request: Registration.RegisterAction.Request)
}

class RegistrationInteractor: RegistrationInteractorProtocol {
    var presenter: RegistrationPresenterProtocol?

    private let authenticationRepository: AuthenticationRepositoryProtocol
    private let keychainService: KeychainServiceProtocol
    private let userRepository: UserRepositoryProtocol

    init(keychainService: KeychainServiceProtocol,
         authenticationRepository: AuthenticationRepositoryProtocol,
         userRepository: UserRepositoryProtocol) {
        self.keychainService = keychainService
        self.authenticationRepository = authenticationRepository
        self.userRepository = userRepository
    }

    deinit {
        print("deinit \(self)")
    }
}

extension RegistrationInteractor {
    func registerUser(request: Registration.RegisterAction.Request) {
        guard let email = request.email, !email.isEmpty,
              let password = request.password, !password.isEmpty,
              let username = request.username, !username.isEmpty,
              let firstName = request.firstName, !firstName.isEmpty,
              let lastName = request.lastName, !lastName.isEmpty
        else {
            let myError = MyError(type: .registrationFieldsRequired, message: nil)
            presenter?.interactor(didFailRegisterAction: Registration.RegisterAction.Response.Failure(myError: myError))
            return
        }
        var user = User(id: nil,
                        username: username,
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        profileImage: nil)
        authenticationRepository.registerUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authenticationResponse):
                user.id = authenticationResponse.userId
                self?.addUserToDatabase(user: user, image: request.image)
            case .failure(let myError):
                self?.presenter?.interactor(didFailRegisterAction: Registration.RegisterAction.Response.Failure(myError: myError))
            }
        }
    }

    private func addUserToDatabase(user: User, image: UIImage?) {
        userRepository.setUser(user: user, userImage: image) { [weak self] result in
            switch result {
            case .success(_):
                self?.keychainService.setUserLoggedIn(true)
                self?.keychainService.setUserId(user.id)
                self?.presenter?.interactor(didSuceedRegisterAction: Registration.RegisterAction.Response.Success())
            case .failure(let myError):
                self?.presenter?.interactor(didFailRegisterAction: Registration.RegisterAction.Response.Failure(myError: myError))
            }
        }
    }
}
