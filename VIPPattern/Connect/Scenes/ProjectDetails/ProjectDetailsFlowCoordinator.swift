 //
//  ProjectDetailsFlowCoordinator.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import UIKit

protocol ProjectDetailsFlowCoordinatorDelegate: FlowCoordinatorDelegate {
    func showConversationDetails(conversationId: String)
}

class ProjectDetailsFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol

    weak var delegate: ProjectDetailsFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        fatalError("Use startWith")
    }

    func startWith(projectId: String) {
        let viewController = ProjectDetailsViewController()
        let projectsRepository = ProjectsRepository(firestoreService: dependencies.firestoreService)
        let userRepository = UserRepository(firestoreService: dependencies.firestoreService)
        let conversationsRepository = ConversationsRepository(firestoreService: dependencies.firestoreService)
        ProjectDetailsConfigurator.configureModule(routerOutput: self,
                                                   viewController: viewController,
                                                   projectId: projectId,
                                                   projectsRepository: projectsRepository,
                                                   userRepository: userRepository,
                                                   conversationsRepository: conversationsRepository,
                                                   keychainService: dependencies.keychainService)
        rootViewController.present(viewController, animated: true)
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProjectDetailsFlowCoordinator: ProjectDetailsRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }

    func showConversationDetails(conversationId: String) {
        delegate?.showConversationDetails(conversationId: conversationId)
    }
}
