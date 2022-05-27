 //
//  EditProjectViewController.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import UIKit

protocol EditProjectPresenterOutput: AnyObject {
}

class EditProjectViewController: UIViewController {
    var editProjectView: EditProjectView?
    var interactor: EditProjectInteractorProtocol?
    var router: EditProjectRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = editProjectView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    deinit {
        router?.shouldClose()
        print("deinit \(self)")
    }
}

extension EditProjectViewController {
}

extension EditProjectViewController: EditProjectPresenterOutput {
}
