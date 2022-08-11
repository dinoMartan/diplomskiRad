 //
//  ConversationDetailsConfigurator.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

class ConversationDetailsConfigurator {
    static func configureModule(routerOutput: ConversationDetailsRouterOutput,
                                viewController: ConversationDetailsViewController,
                                conversationsRepository: ConversationsRepositoryProtocol,
                                conversationId: String) {
        let view = ConversationDetailsView()
        let router = ConversationDetailsRouter()
        let interactor = ConversationDetailsInteractor(conversationsRepository: conversationsRepository,
                                                       conversationId: conversationId)
        let presenter = ConversationDetailsPresenter()

        viewController.conversationDetailsView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.routerOutput = routerOutput
    }
}
