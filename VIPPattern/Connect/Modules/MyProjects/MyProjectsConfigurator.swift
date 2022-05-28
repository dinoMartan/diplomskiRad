 //
//  MyProjectsConfigurator.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

class MyProjectsConfigurator {
    static func configureModule(routerOutput: MyProjectsRouterOutput, viewController: MyProjectsViewController) {
        let view = MyProjectsView()
        let router = MyProjectsRouter()
        let interactor = MyProjectsInteractor()
        let presenter = MyProjectsPresenter()

        viewController.myProjectsView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
