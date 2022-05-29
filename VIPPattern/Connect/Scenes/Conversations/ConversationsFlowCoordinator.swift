 //
//  ConversationsFlowCoordinator.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol ConversationsFlowCoordinatorDelegate: FlowCoordinatorDelegate {
}

class ConversationsFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol
    var viewController: UIViewController?

    weak var delegate: ConversationsFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = ConversationsViewController()
        ConversationsConfigurator.configureModule(routerOutput: self,
                                                  viewController: viewController)
        self.viewController = viewController
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ConversationsFlowCoordinator: ConversationsRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }
}
