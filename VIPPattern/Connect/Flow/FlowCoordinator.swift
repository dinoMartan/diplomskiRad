//
//  FlowCoordinator.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol FlowCoordinatorDelegate: AnyObject {
    func shouldRemoveFlowCoordinator(_ flowCoordinator: FlowCoordinator)
}

protocol FlowCoordinator: AnyObject {
    var childFlowCoordinators: [FlowCoordinator] { get set }
    var dependencies: DependenciesProtocol { get set }
    var rootViewController: UINavigationController { get set }
    func start()
}

extension FlowCoordinator {
    func addChildFlowCoordinator(_ flowCoordinator: FlowCoordinator) {
        for element in childFlowCoordinators {
            if element === flowCoordinator { return }
        }
        childFlowCoordinators.append(flowCoordinator)
    }
        
    func removeChildFlowCoordinator(_ flowCoordinator: FlowCoordinator?) {
        guard childFlowCoordinators.isEmpty == false, let coordinator = flowCoordinator else { return }
        
        for (index, element) in childFlowCoordinators.enumerated() {
            if element === coordinator {
                childFlowCoordinators.remove(at: index)
                break
            }
        }
    }
}
