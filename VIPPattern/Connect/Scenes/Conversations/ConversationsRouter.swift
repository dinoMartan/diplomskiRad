 //
//  ConversationsRouter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol ConversationsRouterOutput: AnyObject {
    func shouldClose()
}

protocol ConversationsRouterProtocol: AnyObject {
    func shouldClose()
}

class ConversationsRouter: ConversationsRouterProtocol {
    weak var routerOutput: ConversationsRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }
}
