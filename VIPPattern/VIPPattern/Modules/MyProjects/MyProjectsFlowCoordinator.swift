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
        MyProjectsConfigurator.configureModule(routerOutput: self,
                                               viewController: viewController)
        self.viewController = viewController
    }

    deinit {
        print("deinit \(self)")
    }
}

extension MyProjectsFlowCoordinator: MyProjectsRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }
}
