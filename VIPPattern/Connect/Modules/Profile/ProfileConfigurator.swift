 //
//  ProfileConfigurator.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

class ProfileConfigurator {
    static func configureModule(routerOutput: ProfileRouterOutput,
                                viewController: ProfileViewController,
                                keychainService: KeychainServiceProtocol,
                                userRepository: UserRepositoryProtocol) {
        let view = ProfileView()
        let router = ProfileRouter()
        let interactor = ProfileInteractor(userRepository: userRepository,
                                           keychainService: keychainService)
        let presenter = ProfilePresenter()

        viewController.profileView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
