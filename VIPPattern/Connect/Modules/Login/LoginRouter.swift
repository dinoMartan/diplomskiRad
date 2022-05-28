//
//  LoginRouter.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol LoginRouterOutput: AnyObject {
    func showRegistration()
    func shouldClose()
    func showMainFlow()
}

protocol LoginRouterProtocol: AnyObject {
    func showRegistration()
    func shouldClose()
    func showMainFlow()
}

class LoginRouter: LoginRouterProtocol {
    weak var loginRouterOutput: LoginRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func showRegistration() {
        loginRouterOutput?.showRegistration()
    }

    func shouldClose() {
        loginRouterOutput?.shouldClose()
    }

    func showMainFlow() {
        loginRouterOutput?.showMainFlow()
    }
}
