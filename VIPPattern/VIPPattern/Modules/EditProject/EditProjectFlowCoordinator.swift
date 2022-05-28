 //
//  EditProjectFlowCoordinator.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import UIKit

protocol EditProjectFlowCoordinatorDelegate: FlowCoordinatorDelegate {
}

class EditProjectFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol

    weak var delegate: EditProjectFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        fatalError("Use startWith()")
    }

    func startWith(project: Project?) {
        let projectsRepository = ProjectsRepository(firestoreService: dependencies.firestoreService)
        let userRepository = UserRepository(firestoreService: dependencies.firestoreService)
        let viewController = EditProjectViewController()
        EditProjectConfigurator.configureModule(routerOutput: self,
                                                viewController: viewController,
                                                project: project,
                                                projectsRepository: projectsRepository,
                                                userRepository: userRepository,
                                                keychainService: dependencies.keychainService)
        rootViewController.pushViewController(viewController, animated: true)
    }

    deinit {
        print("deinit \(self)")
    }
}

extension EditProjectFlowCoordinator: EditProjectRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }
}
