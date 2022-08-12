 //
//  ProfileFlowCoordinator.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import UIKit

protocol ProfileFlowCoordinatorDelegate: FlowCoordinatorDelegate {
    func showLogin()
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
        let userRepository = UserRepository(firestoreService: dependencies.firestoreService)
        let authenticationRepository = AuthenticationRepository(authenticationService: dependencies.authenticationService)
        let viewController = ProfileViewController()
        ProfileConfigurator.configureModule(routerOutput: self,
                                            viewController: viewController,
                                            keychainService: dependencies.keychainService,
                                            userRepository: userRepository,
                                            authenticationRepository: authenticationRepository)
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

    func showLogin() {
        delegate?.showLogin()
    }
}
