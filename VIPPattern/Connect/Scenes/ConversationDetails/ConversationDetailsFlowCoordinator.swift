 //
//  ConversationDetailsFlowCoordinator.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import UIKit

protocol ConversationDetailsFlowCoordinatorDelegate: FlowCoordinatorDelegate {
}

class ConversationDetailsFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol

    weak var delegate: ConversationDetailsFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        fatalError("Use startWith()")
    }

    func startWith(conversationId: String) {
        let viewController = ConversationDetailsViewController()
        let conversationsRepository = ConversationsRepository(firestoreService: dependencies.firestoreService)
        ConversationDetailsConfigurator.configureModule(routerOutput: self,
                                                        viewController: viewController,
                                                        conversationsRepository: conversationsRepository,
                                                        keychainService: dependencies.keychainService,
                                                        conversationId: conversationId)
        rootViewController.pushViewController(viewController, animated: true)
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ConversationDetailsFlowCoordinator: ConversationDetailsRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }
}
