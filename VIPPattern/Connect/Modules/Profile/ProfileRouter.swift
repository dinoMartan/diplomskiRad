 //
//  ProfileRouter.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

protocol ProfileRouterOutput: AnyObject {
    func shouldClose()
}

protocol ProfileRouterProtocol: AnyObject {
    func shouldClose()
}

class ProfileRouter: ProfileRouterProtocol {
    weak var routerOutput: ProfileRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }
}
