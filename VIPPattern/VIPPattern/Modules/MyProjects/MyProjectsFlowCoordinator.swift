 //
//  MyProjectsFlowCoordinator.swift
//  VIPPattern
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
        // let navigationController = UINavigationController(rootViewController: viewController)
        MyProjectsConfigurator.configureModule(routerOutput: self,
                                               viewController: viewController)
        self.viewController = viewController
    }

    deinit {
        print("deinit \(self)")
    }
}

extension MyProjectsFlowCoordinator {
    private func startEditProject(with project: Project?) {
        let editProjectFlowCoordinator = EditProjectFlowCoordinator(rootViewController: rootViewController,
                                                                    dependencies: dependencies)
        addChildFlowCoordinator(editProjectFlowCoordinator)
        editProjectFlowCoordinator.delegate = self
        editProjectFlowCoordinator.startWith(project: project)
    }
}

extension MyProjectsFlowCoordinator: MyProjectsRouterOutput,
                                     EditProjectFlowCoordinatorDelegate {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }

    func showEditProject(project: Project?) {
        startEditProject(with: project)
    }

    func shouldRemoveFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        removeChildFlowCoordinator(flowCoordinator)
    }
}
