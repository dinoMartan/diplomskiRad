 //
//  MyProjectsConfigurator.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

class MyProjectsConfigurator {
    static func configureModule(routerOutput: MyProjectsRouterOutput,
                                viewController: MyProjectsViewController,
                                projectsRepository: ProjectsRepositoryProtocol,
                                keychainService: KeychainServiceProtocol) {
        let view = MyProjectsView()
        let router = MyProjectsRouter()
        let interactor = MyProjectsInteractor(projectsRepository: projectsRepository,
                                              keychainService: keychainService)
        let presenter = MyProjectsPresenter()

        viewController.myProjectsView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
