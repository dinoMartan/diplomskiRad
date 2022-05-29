 //
//  ProfileInteractor.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation
import UIKit

protocol ProfileInteractorProtocol {
    func getUserData(request: Profile.GetUserDataAction.Request)
    func updateSetting(request: Profile.UpdateSettingAction.Request)
}

class ProfileInteractor: ProfileInteractorProtocol {
    var presenter: ProfilePresenterProtocol?

    private let userRepository: UserRepositoryProtocol
    private let keychainService: KeychainServiceProtocol

    private var user: User?

    init(userRepository: UserRepositoryProtocol, keychainService: KeychainServiceProtocol) {
        self.userRepository = userRepository
        self.keychainService = keychainService
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProfileInteractor {
    func getUserData(request: Profile.GetUserDataAction.Request) {
        guard let userId = keychainService.getUserId() else { return }
        userRepository.getUser(userId: userId) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                self?.presenter?.interactor(getUserDataActionSuccess: Profile.GetUserDataAction.ResponseSuccess(user: user))
            case .failure(let myError):
                self?.presenter?.interactor(didFail: Profile.ResponseFailure(myError: myError))
            }
        }
    }

    func updateSetting(request: Profile.UpdateSettingAction.Request) {
        let value = request.setting.value
        switch request.setting.type {
        case .firstName:
            user?.firstName = value
            updateUser(user: user)
        case .lastName:
            user?.lastName = value
            updateUser(user: user)
        case .username:
            user?.username = value
            updateUser(user: user)
        case .image(let image):
            updateUser(user: user, userImage: image)
        }
    }

    private func updateUser(user: User?, userImage: UIImage? = nil) {
        guard let user = user else { return }
        userRepository.setUser(user: user, userImage: userImage) { [weak self] result in
            switch result {
            case .success(_):
                self?.getUserData(request: Profile.GetUserDataAction.Request())
            case .failure(let myError):
                self?.presenter?.interactor(didFail: Profile.ResponseFailure(myError: myError))
            }
        }
    }
}
