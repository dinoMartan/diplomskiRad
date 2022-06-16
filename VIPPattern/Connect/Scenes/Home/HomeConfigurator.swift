 //
//  HomeConfigurator.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

class HomeConfigurator {
    static func configureModule(routerOutput: HomeRouterOutput,
                                viewController: HomeViewController,
                                projectsRepository: ProjectsRepositoryProtocol) {
        let view = HomeView()
        let router = HomeRouter()
        let interactor = HomeInteractor(projectsRepository: projectsRepository)
        let presenter = HomePresenter()

        viewController.view = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
