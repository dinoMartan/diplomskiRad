 //
//  ConversationsConfigurator.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

class ConversationsConfigurator {
    static func configureModule(routerOutput: ConversationsRouterOutput, viewController: ConversationsViewController) {
        let view = ConversationsView()
        let router = ConversationsRouter()
        let interactor = ConversationsInteractor()
        let presenter = ConversationsPresenter()

        viewController.view = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
