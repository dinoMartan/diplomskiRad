//
//  RegistrationViewController.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol RegistrationPresenterOutput: AnyObject {
    func presenterDidSucceedRegistration()
    func presenter(didFail myError: MyError)
}

class RegistrationViewController: UIViewController {
    var registrationView: RegistrationView?
    var interactor: RegistrationInteractorProtocol?
    var router: RegistrationRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = registrationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInteractions()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        router?.shouldClose()
    }

    deinit {
        print("deinit \(self)")
    }
}

extension RegistrationViewController {
    private func setupInteractions() {
        registrationView?.registerButtonTapInteraction = { [weak self] in
            self?.interactor?.registerUser(email: self?.registrationView?.emailTextField.text,
                                           password: self?.registrationView?.passwordTextField.text)
        }
    }
}

extension RegistrationViewController: RegistrationPresenterOutput {
    func presenterDidSucceedRegistration() {
        dismiss(animated: true) { [weak self] in
            self?.router?.showMainFlow()
        }
    }

    func presenter(didFail myError: MyError) {
        showMyErrorAlert(myError)
    }
}
