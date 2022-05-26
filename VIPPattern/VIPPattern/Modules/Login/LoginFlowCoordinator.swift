//
//  LoginFlowCoordinator.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol LoginFlowCoordinatorDelegate: FlowCoordinatorDelegate {
    func showRegistration()
    func showMainFlow()
}

class LoginFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol

    weak var delegate: LoginFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        startLoginFlow()
    }

    deinit {
        print("deinit \(self)")
    }
}

extension LoginFlowCoordinator {
    private func startLoginFlow() {
        let authenticationService = AuthenticationService()
        let loginViewController = LoginViewController()
        LoginConfigurator.configureModule(loginRouterOutput: self,
                                          viewController: loginViewController,
                                          keychainService: dependencies.keychainService,
                                          authenticationService: authenticationService)
        rootViewController.setViewControllers([loginViewController], animated: true)
    }
}

extension LoginFlowCoordinator: LoginRouterOutput {
    func showRegistration() {
        delegate?.showRegistration()
    }

    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }

    func showMainFlow() {
        delegate?.showMainFlow()
    }
}
