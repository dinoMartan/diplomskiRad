 //
//  TabBarViewController.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

class TabBarViewController: UITabBarController {
    var router: TabBarRouterProtocol?

    override func loadView() {
        super.loadView()
        setupTabBar()
        view.backgroundColor = .systemBackground
    }

    deinit {
        router?.shouldClose()
        print("deinit \(self)")
    }
}

extension TabBarViewController {
    private func setupTabBar() {
        tabBar.tintColor = .white
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemGray3
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
}
