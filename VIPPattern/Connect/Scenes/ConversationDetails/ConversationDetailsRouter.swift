 //
//  ConversationDetailsRouter.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

protocol ConversationDetailsRouterOutput: AnyObject {
    func shouldClose()
}

protocol ConversationDetailsRouterProtocol: AnyObject {
    func shouldClose()
}

class ConversationDetailsRouter: ConversationDetailsRouterProtocol {
    weak var routerOutput: ConversationDetailsRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }
}
