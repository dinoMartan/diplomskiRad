 //
//  MyProjectsRouter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol MyProjectsRouterOutput: AnyObject {
    func shouldClose()
    func showEditProject(projectId: String?)
}

protocol MyProjectsRouterProtocol: AnyObject {
    func shouldClose()
    func showEditProject(projectId: String)
    func addNewProject()
}

class MyProjectsRouter: MyProjectsRouterProtocol {
    weak var routerOutput: MyProjectsRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }

    func showEditProject(projectId: String) {
        routerOutput?.showEditProject(projectId: projectId)
    }

    func addNewProject() {
        routerOutput?.showEditProject(projectId: nil)
    }
}
