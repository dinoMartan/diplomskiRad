 //
//  ConversationsRouter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol ConversationsRouterOutput: AnyObject {
    func shouldClose()
    func showConversationDetails(conversationId: String)
}

protocol ConversationsRouterProtocol: AnyObject {
    func shouldClose()
    func showConversationDetails(conversationId: String)
}

class ConversationsRouter: ConversationsRouterProtocol {
    weak var routerOutput: ConversationsRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }

    func showConversationDetails(conversationId: String) {
        routerOutput?.showConversationDetails(conversationId: conversationId)
    }
}
