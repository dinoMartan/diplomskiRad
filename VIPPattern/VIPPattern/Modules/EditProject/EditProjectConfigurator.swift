 //
//  EditProjectConfigurator.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

class EditProjectConfigurator {
    static func configureModule(routerOutput: EditProjectRouterOutput, viewController: EditProjectViewController, project: Project?) {
        let view = EditProjectView()
        let router = EditProjectRouter()
        let interactor = EditProjectInteractor(project: project)
        let presenter = EditProjectPresenter()

        viewController.editProjectView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
