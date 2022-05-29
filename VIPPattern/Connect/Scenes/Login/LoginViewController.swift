//
//  LoginViewController.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol LoginPresenterOutput: AnyObject {
    func presenter(didSucceedLogin viewModel: Login.LoginAction.ViewModelSuccess)
    func presenter(didSucceedForgottenPassword viewModel: Login.ForgottenPasswordAction.ViewModelSuccess)
    func presenter(didFail viewModel: Login.ViewModelFailure)
}

class LoginViewController: UIViewController {
    var loginView: LoginView?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = loginView
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

extension LoginViewController {
    private func setupInteractions() {
        loginView?.loginButtonTapInteraction = { [weak self] in
            let email = self?.loginView?.emailTextField.text
            let password = self?.loginView?.passwordTextField.text
            self?.interactor?.loginUser(request: Login.LoginAction.Request(email: email,
                                                                           password: password))
        }

        loginView?.registerButtonTapInteraction = { [weak self] in
            self?.router?.showRegistration()
        }

        loginView?.forgottenPasswordButtonTapInteraction = { [weak self] in
            self?.handleForgottenPasswordButtonTap()
        }
    }

    private func handleForgottenPasswordButtonTap() {
        showAlertControllerWithTextField(title: "Zaboravljena lozinka",
                                         message: nil,
                                         placeholder: "Email") { [weak self] email in
            self?.interactor?.forgottenPassword(request: Login.ForgottenPasswordAction.Request(email: email))
        }
    }
}

extension LoginViewController: LoginPresenterOutput {
    func presenter(didSucceedLogin viewModel: Login.LoginAction.ViewModelSuccess) {
        router?.showMainFlow()
    }

    func presenter(didSucceedForgottenPassword viewModel: Login.ForgottenPasswordAction.ViewModelSuccess) {
        showAlert(title: viewModel.title,
                  message: viewModel.message)
    }

    func presenter(didFail viewModel: Login.ViewModelFailure) {
        showMyErrorAlert(viewModel.myError)
    }
}
