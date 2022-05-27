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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getUserData()
    }

    deinit {
        router?.shouldClose()
        print("deinit \(self)")
    }
}

extension ProfileViewController {
}

extension ProfileViewController: ProfilePresenterOutput {
}
