 //
//  TabBarFlowCoordinator.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol TabBarFlowCoordinatorDelegate: FlowCoordinatorDelegate {
}

class TabBarFlowCoordinator: FlowCoordinator {
    var childFlowCoordinators = [FlowCoordinator]()
    var rootViewController: UINavigationController
    internal var dependencies: DependenciesProtocol
    var tabBarViewController: TabBarViewController?

    weak var delegate: TabBarFlowCoordinatorDelegate?

    init(rootViewController: UINavigationController, dependencies: DependenciesProtocol) {
        self.rootViewController = rootViewController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = TabBarViewController()
        TabBarConfigurator.configureModule(routerOutput: self,
                                           viewController: viewController)
        tabBarViewController = viewController
        setupViewControllers()
        viewController.selectedIndex = 1
        rootViewController.setViewControllers([viewController], animated: true)
    }

    deinit {
        print("deinit \(self)")
    }
}

extension TabBarFlowCoordinator {
    private func setupViewControllers() {
        let viewControllers = [
            getMyProjectsViewController(),
            getHomeViewController(),
            getConversationsViewController(),
            getProfileViewController()
        ].compactMap { $0 }
        tabBarViewController?.setViewControllers(viewControllers, animated: true)
    }

    private func setupTabBarItemFor(_ viewController: UIViewController?, image: String, title: String) {
        viewController?.tabBarItem.title = title
        viewController?.tabBarItem.image = UIImage(systemName: image)
    }

    private func getHomeViewController() -> UIViewController? {
        let homeFlowCoordinator = HomeFlowCoordinator(rootViewController: rootViewController,
                                                      dependencies: dependencies)
        addChildFlowCoordinator(homeFlowCoordinator)
        homeFlowCoordinator.delegate = self
        homeFlowCoordinator.start()
        let viewController = homeFlowCoordinator.homeViewController
        setupTabBarItemFor(viewController, image: "house.fill", title: "Početna")
        return viewController
    }

    private func getMyProjectsViewController() -> UIViewController? {
        let myProjectsFlowCoordinator = MyProjectsFlowCoordinator(rootViewController: rootViewController,
                                                                  dependencies: dependencies)
        addChildFlowCoordinator(myProjectsFlowCoordinator)
        myProjectsFlowCoordinator.delegate = self
        myProjectsFlowCoordinator.start()
        let viewController = myProjectsFlowCoordinator.viewController
        setupTabBarItemFor(viewController, image: "pencil", title: "Moji projekti")
        return viewController
    }

    private func getConversationsViewController() -> UIViewController? {
        let conversationsFlowCoordinator = ConversationsFlowCoordinator(rootViewController: rootViewController,
                                                                        dependencies: dependencies)
        addChildFlowCoordinator(conversationsFlowCoordinator)
        conversationsFlowCoordinator.delegate = self
        conversationsFlowCoordinator.start()
        let viewController = conversationsFlowCoordinator.viewController
        setupTabBarItemFor(viewController, image: "message.fill", title: "Razgovori")
        return viewController
    }

    private func getProfileViewController() -> UIViewController? {
        let profileFlowCoordinator = ProfileFlowCoordinator(rootViewController: rootViewController,
                                                            dependencies: dependencies)
        addChildFlowCoordinator(profileFlowCoordinator)
        profileFlowCoordinator.delegate = self
        profileFlowCoordinator.start()
        let viewController = profileFlowCoordinator.viewController
        setupTabBarItemFor(viewController, image: "person.fill", title: "Profil")
        return viewController
    }
}

extension TabBarFlowCoordinator: TabBarRouterOutput {
    func shouldClose() {
        delegate?.shouldRemoveFlowCoordinator(self)
    }
}

extension TabBarFlowCoordinator: HomeFlowCoordinatorDelegate,
                                 MyProjectsFlowCoordinatorDelegate,
                                 ConversationsFlowCoordinatorDelegate,
                                 ProfileFlowCoordinatorDelegate {
    func shouldRemoveFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        removeChildFlowCoordinator(flowCoordinator)
    }
}
