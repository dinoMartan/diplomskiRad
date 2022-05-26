 //
//  MyProjectsRouter.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol MyProjectsRouterOutput: AnyObject {
    func shouldClose()
}

protocol MyProjectsRouterProtocol: AnyObject {
    func shouldClose()
}

class MyProjectsRouter: MyProjectsRouterProtocol {
    weak var routerOutput: MyProjectsRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }
}
