 //
//  MyProjectsRouter.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol MyProjectsRouterOutput: AnyObject {
    func shouldClose()
    func showEditProject(project: Project?)
}

protocol MyProjectsRouterProtocol: AnyObject {
    func shouldClose()
    func showEditProject(project: Project)
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

    func showEditProject(project: Project) {
        routerOutput?.showEditProject(project: project)
    }

    func addNewProject() {
        routerOutput?.showEditProject(project: nil)
    }
}
