 //
//  EditProjectRouter.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

protocol EditProjectRouterOutput: AnyObject {
    func shouldClose()
}

protocol EditProjectRouterProtocol: AnyObject {
    func shouldClose()
}

class EditProjectRouter: EditProjectRouterProtocol {
    weak var routerOutput: EditProjectRouterOutput?

    deinit {
        print("deinit \(self)")
    }

    func shouldClose() {
        routerOutput?.shouldClose()
    }
}
