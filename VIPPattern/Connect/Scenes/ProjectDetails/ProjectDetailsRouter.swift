 //
//  ProjectDetailsRouter.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

protocol ProjectDetailsRouterOutput: AnyObject {
    func shouldClose()
    func showConversationDetails(conversationId: String)
}

protocol ProjectDetailsRouterProtocol: AnyObject {
    func shouldClose()
    func showConversationDetails(conversationId: String)
}

class ProjectDetailsRouter: ProjectDetailsRouterProtocol {
    weak var routerOutput: ProjectDetailsRouterOutput?

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
