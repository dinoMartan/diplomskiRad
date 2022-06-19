 //
//  ProjectDetailsRouter.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

protocol ProjectDetailsRouterOutput: AnyObject {
    func shouldClose()
}

protocol ProjectDetailsRouterProtocol: AnyObject {
    func shouldClose()
}

class ProjectDetailsRouter: ProjectDetailsRouterProtocol {
    weak var routerOutput: ProjectDetailsRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }
}
