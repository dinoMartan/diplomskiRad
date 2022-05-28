 //
//  TabBarRouter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol TabBarRouterOutput: AnyObject {
    func shouldClose()
}

protocol TabBarRouterProtocol: AnyObject {
    func shouldClose()
}

class TabBarRouter: TabBarRouterProtocol {
    weak var routerOutput: TabBarRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }
}
