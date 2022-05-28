 //
//  TabBarConfigurator.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

class TabBarConfigurator {
    static func configureModule(routerOutput: TabBarRouterOutput, viewController: TabBarViewController) {
        let router = TabBarRouter()

        viewController.router = router

        router.routerOutput = routerOutput
    }
}
