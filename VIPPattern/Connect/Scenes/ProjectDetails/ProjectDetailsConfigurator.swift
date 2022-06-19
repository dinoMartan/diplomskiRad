 //
//  ProjectDetailsConfigurator.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

class ProjectDetailsConfigurator {
    static func configureModule(routerOutput: ProjectDetailsRouterOutput,
                                viewController: ProjectDetailsViewController,
                                projectId: String,
                                projectsRepository: ProjectsRepositoryProtocol,
                                userRepository: UserRepositoryProtocol,
                                conversationsRepository: ConversationsRepositoryProtocol,
                                keychainService: KeychainServiceProtocol) {
        let view = ProjectDetailsView()
        let router = ProjectDetailsRouter()
        let interactor = ProjectDetailsInteractor(projectsRepository: projectsRepository,
                                                  userRepository: userRepository,
                                                  keychainService: keychainService,
                                                  conversationsRepository: conversationsRepository,
                                                  projectId: projectId)
        let presenter = ProjectDetailsPresenter()

        viewController.projectDetailsView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
