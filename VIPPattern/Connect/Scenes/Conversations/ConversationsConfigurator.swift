 //
//  ConversationsConfigurator.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

class ConversationsConfigurator {
    static func configureModule(routerOutput: ConversationsRouterOutput,
                                viewController: ConversationsViewController,
                                keychainService: KeychainServiceProtocol,
                                conversationsRepository: ConversationsRepositoryProtocol) {
        let view = ConversationsView()
        let router = ConversationsRouter()
        let interactor = ConversationsInteractor(keychainServices: keychainService,
                                                 conversationsRepository: conversationsRepository)
        let presenter = ConversationsPresenter()

        viewController.conversationsView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
