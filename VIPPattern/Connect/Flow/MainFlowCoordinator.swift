//
//  MainFlowCoordinator.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol MainFlowCoordinatorDelegate: FlowCoordinatorDelegate {
    func showLogin()
}

class MainFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol

    weak var delegate: MainFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        showTabBar()
    }

    private func showTabBar() {
        let tabBarFlowCoordinator = TabBarFlowCoordinator(rootViewController: rootViewController,
                                                          dependencies: dependencies)
        addChildFlowCoordinator(tabBarFlowCoordinator)
        tabBarFlowCoordinator.delegate = self
        tabBarFlowCoordinator.start()
    }
}

extension MainFlowCoordinator: TabBarFlowCoordinatorDelegate {
    func shouldRemoveFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        removeChildFlowCoordinator(flowCoordinator)
    }

    func showLogin() {
        delegate?.showLogin()
    }
}
