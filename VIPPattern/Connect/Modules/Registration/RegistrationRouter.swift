//
//  RegistrationRouter.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol RegistrationRouterOutput: AnyObject {
    func shouldClose()
    func showMainFlow()
}

protocol RegistrationRouterProtocol: AnyObject {
    func shouldClose()
    func showMainFlow()
}

class RegistrationRouter: RegistrationRouterProtocol {
    weak var registrationRouterOutput: RegistrationRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        registrationRouterOutput?.shouldClose()
    }

    func showMainFlow() {
        registrationRouterOutput?.showMainFlow()
    }
}
