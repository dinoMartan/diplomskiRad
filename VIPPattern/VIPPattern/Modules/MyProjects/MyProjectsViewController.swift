 //
//  MyProjectsViewController.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol MyProjectsPresenterOutput: AnyObject {
}

class MyProjectsViewController: UIViewController {
    var viewMyProjects: MyProjectsView?
    var interactor: MyProjectsInteractorProtocol?
    var router: MyProjectsRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = viewMyProjects
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            router?.shouldClose()
        }
    }

    deinit {
        print("deinit \(self)")
    }
}

extension MyProjectsViewController {
}

extension MyProjectsViewController: MyProjectsPresenterOutput {
}
