 //
//  EditProjectConfigurator.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

class EditProjectConfigurator {
    static func configureModule(routerOutput: EditProjectRouterOutput,
                                viewController: EditProjectViewController,
                                projectId: String?,
                                projectsRepository: ProjectsRepositoryProtocol,
                                userRepository: UserRepositoryProtocol,
                                keychainService: KeychainServiceProtocol) {
        let view = EditProjectView()
        let router = EditProjectRouter()
        let interactor = EditProjectInteractor(projectId: projectId,
                                               projectsRepository: projectsRepository,
                                               userRepository: userRepository,
                                               keychainService: keychainService)
        let presenter = EditProjectPresenter()

        viewController.editProjectView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
