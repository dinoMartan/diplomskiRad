 //
//  HomeFlowCoordinator.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol HomeFlowCoordinatorDelegate: FlowCoordinatorDelegate {
}

class HomeFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol
    var homeViewController: UIViewController?

    weak var delegate: HomeFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = HomeViewController()
        let projectsRepository = ProjectsRepository(firestoreService: dependencies.firestoreService)
        HomeConfigurator.configureModule(routerOutput: self,
                                         viewController: viewController,
                                         projectsRepository: projectsRepository)
        homeViewController = viewController
    }

    deinit {
        print("deinit \(self)")
    }

    private func showProjectDetailsFlow(projectId: String) {
        let projectDetailsFlowCoordinator = ProjectDetailsFlowCoordinator(rootViewController: rootViewController,
                                                                          dependencies: dependencies)
        addChildFlowCoordinator(projectDetailsFlowCoordinator)
        projectDetailsFlowCoordinator.delegate = self
        projectDetailsFlowCoordinator.startWith(projectId: projectId)
    }
}

extension HomeFlowCoordinator: HomeRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }

    func showProjectDetails(projectId: String) {
        showProjectDetailsFlow(projectId: projectId)
    }
}

extension HomeFlowCoordinator: ProjectDetailsFlowCoordinatorDelegate {
    func shouldRemoveFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        removeChildFlowCoordinator(flowCoordinator)
    }
}
