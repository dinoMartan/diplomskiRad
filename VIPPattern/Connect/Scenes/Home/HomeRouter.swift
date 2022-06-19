 //
//  HomeRouter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol HomeRouterOutput: AnyObject {
    func shouldClose()
    func showProjectDetails(projectId: String)
}

protocol HomeRouterProtocol: AnyObject {
    func shouldClose()
    func showProjectDetails(projectId: String)
}

class HomeRouter: HomeRouterProtocol {
    weak var routerOutput: HomeRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }

    func showProjectDetails(projectId: String) {
        routerOutput?.showProjectDetails(projectId: projectId)
    }
}
