 //
//  ProfileViewController.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import UIKit

protocol ProfilePresenterOutput: AnyObject {
}

class ProfileViewController: UIViewController {
    var viewProfile: ProfileView?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = viewProfile
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        router?.shouldClose()
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProfileViewController {
}

extension ProfileViewController: ProfilePresenterOutput {
}
