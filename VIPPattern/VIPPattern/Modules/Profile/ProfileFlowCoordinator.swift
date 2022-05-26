 //
//  ProfileFlowCoordinator.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import UIKit

protocol ProfileFlowCoordinatorDelegate: FlowCoordinatorDelegate {
}

class ProfileFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol
    var viewController: ProfileViewController?

    weak var delegate: ProfileFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = ProfileViewController()
        ProfileConfigurator.configureModule(routerOutput: self,
                                            viewController: viewController)
        self.viewController = viewController
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProfileFlowCoordinator: ProfileRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }
}
