 //
//  TabBarViewController.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

class TabBarViewController: UITabBarController {
    var router: TabBarRouterProtocol?

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        router?.shouldClose()
    }

    override func loadView() {
        super.loadView()
        setupTabBar()
        view.backgroundColor = .systemBackground
    }

    deinit {
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
