//
//  AppFlowCoordinator.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

class AppFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        startLogin()
        return
        guard dependencies.keychainService.getUserLoggedIn() else {
            startLogin()
            return
        }
        startMainFlow()
    }

    private func startMainFlow() {
        let mainFlowCoordinator = MainFlowCoordinator(rootViewController: rootViewController,
                                                      dependencies: dependencies)
        addChildFlowCoordinator(mainFlowCoordinator)
        mainFlowCoordinator.delegate = self
        mainFlowCoordinator.start()
    }

    private func startLogin() {
        let loginFlowCoordinator = LoginFlowCoordinator(rootViewController: rootViewController,
                                                        dependencies: dependencies)
        addChildFlowCoordinator(loginFlowCoordinator)
        loginFlowCoordinator.delegate = self
        loginFlowCoordinator.start()
    }

    private func startRegistration() {
        let registrationFlowCoordinator =  RegistrationFlowCoordinator(rootViewController: rootViewController,
                                    dependencies: dependencies)
        addChildFlowCoordinator(registrationFlowCoordinator)
        registrationFlowCoordinator.delegate = self
        registrationFlowCoordinator.start()
    }
}

extension AppFlowCoordinator: FlowCoordinatorDelegate {
    func shouldRemoveFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        removeChildFlowCoordinator(flowCoordinator)
    }
}

extension AppFlowCoordinator: LoginFlowCoordinatorDelegate, RegistrationFlowCoordinatorDelegate {
    func showRegistration() {
        startRegistration()
    }

    func showMainFlow() {
        startMainFlow()
    }
}
