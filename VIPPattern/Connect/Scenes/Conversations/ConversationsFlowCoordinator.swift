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
        let conversationsRepository = ConversationsRepository(firestoreService: dependencies.firestoreService)
        ConversationsConfigurator.configureModule(routerOutput: self,
                                                  viewController: viewController,
                                                  keychainService: dependencies.keychainService,
                                                  conversationsRepository: conversationsRepository)
        self.viewController = viewController
    }

    private func showConversationDetailsScene(conversationId: String) {
        let conversationDetailsFlowCoordinator = ConversationDetailsFlowCoordinator(rootViewController: rootViewController,
                                                                                    dependencies: dependencies)
        addChildFlowCoordinator(conversationDetailsFlowCoordinator)
        conversationDetailsFlowCoordinator.delegate = self
        conversationDetailsFlowCoordinator.startWith(conversationId: conversationId)
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ConversationsFlowCoordinator: ConversationsRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }

    func showConversationDetails(conversationId: String) {
        showConversationDetailsScene(conversationId: conversationId)
    }
}

extension ConversationsFlowCoordinator: ConversationDetailsFlowCoordinatorDelegate {
    func shouldRemoveFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        removeChildFlowCoordinator(flowCoordinator)
    }
}
