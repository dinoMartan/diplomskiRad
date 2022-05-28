 //
//  HomeConfigurator.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

class HomeConfigurator {
    static func configureModule(routerOutput: HomeRouterOutput, viewController: HomeViewController) {
        let view = HomeView()
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()

        viewController.view = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
