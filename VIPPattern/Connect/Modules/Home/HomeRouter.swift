 //
//  HomeRouter.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol HomeRouterOutput: AnyObject {
    func shouldClose()
}

protocol HomeRouterProtocol: AnyObject {
    func shouldClose()
}

class HomeRouter: HomeRouterProtocol {
    weak var routerOutput: HomeRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }
}
