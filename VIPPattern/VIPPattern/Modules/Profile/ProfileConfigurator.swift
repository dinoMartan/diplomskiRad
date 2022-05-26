 //
//  ProfileConfigurator.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

class ProfileConfigurator {
    static func configureModule(routerOutput: ProfileRouterOutput, viewController: ProfileViewController) {
        let view = ProfileView()
        let router = ProfileRouter()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()

        viewController.view = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
