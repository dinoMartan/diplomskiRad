//
//  RegistrationFlowCoordinator.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol RegistrationFlowCoordinatorDelegate: FlowCoordinatorDelegate {
    func showMainFlow()
}

class RegistrationFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol

    weak var delegate: RegistrationFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        startRegistrationFlow()
    }

    deinit {
        print("deinit \(self)")
    }
}

extension RegistrationFlowCoordinator {
    private func startRegistrationFlow() {
        let authenticationService = AuthenticationService()
        let userRepository = UserRepository(firestoreService: dependencies.firestoreService)
        let registrationViewController = RegistrationViewController()
        RegistrationConfigurator.configureModule(registrationRouterOutput: self,
                                                 viewController: registrationViewController,
                                                 keychainService: dependencies.keychainService,
                                                 authenticationService: authenticationService,
                                                 userRepository: userRepository)
        rootViewController.present(registrationViewController, animated: true)
    }
}

extension RegistrationFlowCoordinator: RegistrationRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }

    func showMainFlow() {
        delegate?.showMainFlow()
    }
}
