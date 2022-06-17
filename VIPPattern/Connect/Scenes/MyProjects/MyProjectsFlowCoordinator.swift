 //
//  MyProjectsFlowCoordinator.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol MyProjectsFlowCoordinatorDelegate: FlowCoordinatorDelegate {
}

class MyProjectsFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol
    var viewController: UIViewController?

    weak var delegate: MyProjectsFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = MyProjectsViewController()
        let projectsRepository = ProjectsRepository(firestoreService: dependencies.firestoreService)
        MyProjectsConfigurator.configureModule(routerOutput: self,
                                               viewController: viewController,
                                               projectsRepository: projectsRepository,
                                               keychainService: dependencies.keychainService)
        self.viewController = viewController
    }

    deinit {
        print("deinit \(self)")
    }
}

extension MyProjectsFlowCoordinator {
    private func startEditProject(with projectId: String?) {
        let editProjectFlowCoordinator = EditProjectFlowCoordinator(rootViewController: rootViewController,
                                                                    dependencies: dependencies)
        addChildFlowCoordinator(editProjectFlowCoordinator)
        editProjectFlowCoordinator.delegate = self
        editProjectFlowCoordinator.startWith(projectId: projectId)
    }
}

extension MyProjectsFlowCoordinator: MyProjectsRouterOutput,
                                     EditProjectFlowCoordinatorDelegate {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }

    func showEditProject(projectId: String?) {
        startEditProject(with: projectId)
    }

    func shouldRemoveFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        removeChildFlowCoordinator(flowCoordinator)
    }
}
