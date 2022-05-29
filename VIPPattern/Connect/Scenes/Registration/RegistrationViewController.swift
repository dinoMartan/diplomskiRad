//
//  RegistrationViewController.swift
//  Connect
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

    deinit {
        router?.shouldClose()
        print("deinit \(self)")
    }
}

extension RegistrationViewController {
    private func setupInteractions() {
        registrationView?.registerButtonTapInteraction = { [weak self] in
            self?.interactor?.registerUser(username: self?.registrationView?.usernameTextField.text,
                                           firstName: self?.registrationView?.firstNameTextField.text,
                                           lastName: self?.registrationView?.lastNameTextField.text,
                                           email: self?.registrationView?.emailTextField.text,
                                           password: self?.registrationView?.passwordTextField.text,
                                           image: self?.registrationView?.imageView.image)
        }

        registrationView?.imageTapInteraction = { [weak self] in
            guard let self = self else { return }
            ImagePickerManager().pickImage(self) { image in
                self.registrationView?.imageView.image = image
            }
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
