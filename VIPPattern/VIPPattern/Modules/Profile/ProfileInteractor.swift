 //
//  ProfileInteractor.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

protocol ProfileInteractorProtocol {
    func getUserData()
}

class ProfileInteractor: ProfileInteractorProtocol {
    var presenter: ProfilePresenterProtocol?

    private let userRepository: UserRepositoryProtocol
    private let keychainService: KeychainServiceProtocol

    init(userRepository: UserRepositoryProtocol, keychainService: KeychainServiceProtocol) {
        self.userRepository = userRepository
        self.keychainService = keychainService
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProfileInteractor {
    func getUserData() {
        guard let userId = keychainService.getUserId() else { return }
        userRepository.getUser(userId: userId) { [weak self] result in
            switch result {
            case .success(let user):
                self?.presenter?.interactor(didFetchUser: user)
            case .failure(let myError):
                self?.presenter?.interactor(didFail: myError)
            }
        }
    }

}
