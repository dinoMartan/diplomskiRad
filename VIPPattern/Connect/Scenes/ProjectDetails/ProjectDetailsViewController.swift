 //
//  ProjectDetailsViewController.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import UIKit

protocol ProjectDetailsPresenterOutput: AnyObject {
}

class ProjectDetailsViewController: UIViewController {
    var projectDetailsView: ProjectDetailsView?
    var interactor: ProjectDetailsInteractorProtocol?
    var router: ProjectDetailsRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = projectDetailsView
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        router?.shouldClose()
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProjectDetailsViewController {
}

extension ProjectDetailsViewController: ProjectDetailsPresenterOutput {
}
