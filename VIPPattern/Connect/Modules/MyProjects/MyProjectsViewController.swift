 //
//  MyProjectsViewController.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol MyProjectsPresenterOutput: AnyObject {
}

class MyProjectsViewController: UIViewController {
    var myProjectsView: MyProjectsView?
    var interactor: MyProjectsInteractorProtocol?
    var router: MyProjectsRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = myProjectsView
        setupActions()
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
    private func setupActions() {
        myProjectsView?.addProjectButtonAction = { [weak self] in
            self?.router?.addNewProject()
        }
    }
}

extension MyProjectsViewController: MyProjectsPresenterOutput {
}
