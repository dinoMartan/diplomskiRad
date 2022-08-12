 //
//  ProfileRouter.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

protocol ProfileRouterOutput: AnyObject {
    func shouldClose()
    func showLogin()
}

protocol ProfileRouterProtocol: AnyObject {
    func shouldClose()
    func showLogin()
}

class ProfileRouter: ProfileRouterProtocol {
    weak var routerOutput: ProfileRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }

    func showLogin() {
        routerOutput?.showLogin()
    }
}
