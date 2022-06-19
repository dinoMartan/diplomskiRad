//
//  RegistrationViewController.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol RegistrationPresenterOutput: AnyObject {
    func presenter(didSucceedRegister viewModel: Registration.RegisterAction.ViewModel.Success)
    func presenter(didFailRegister viewModel: Registration.RegisterAction.ViewModel.Failure)
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
            guard let request = self?.getRegisterActionRequest() else { return }
            self?.interactor?.registerUser(request: request)
        }

        registrationView?.imageTapInteraction = { [weak self] in
            guard let self = self else { return }
            ImagePickerManager().pickImage(self) { image in
                self.registrationView?.imageView.image = image
            }
        }
    }

    private func getRegisterActionRequest() -> Registration.RegisterAction.Request {
        Registration.RegisterAction.Request(username: registrationView?.usernameTextFieldView.textField.text,
                                            firstName: registrationView?.firstNameTextFieldView.textField.text,
                                            lastName: registrationView?.lastNameTextFieldView.textField.text,
                                            email: registrationView?.emailTextFieldView.textField.text,
                                            password: registrationView?.passwordTextFieldView.textField.text,
                                            image: registrationView?.imageView.image)
    }
}

extension RegistrationViewController: RegistrationPresenterOutput {
    func presenter(didSucceedRegister viewModel: Registration.RegisterAction.ViewModel.Success) {
        dismiss(animated: true) { [weak self] in
            self?.router?.showMainFlow()
        }
    }

    func presenter(didFailRegister viewModel: Registration.RegisterAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
