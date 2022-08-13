//
//  LoginViewController.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol LoginPresenterOutput: AnyObject {
    func presenter(didSucceedLogin viewModel: Login.LoginAction.ViewModel.Success)
    func presenter(didFailLogin viewModel: Login.LoginAction.ViewModel.Failure)
    func presenter(didSucceedForgottenPassword viewModel: Login.ForgottenPasswordAction.ViewModel.Success)
    func presenter(didFailForgottenPassword viewModel: Login.ForgottenPasswordAction.ViewModel.Failure)
}

class LoginViewController: UIViewController {
    var loginView: LoginView?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = loginView
        navigationController?.navigationBar.isHidden = true
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
            guard let email = self?.loginView?.emailTextFieldView.textField.text,
                  let password = self?.loginView?.passwordTextFieldView.textField.text
            else { return }
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
            guard let email = email else { return }
            self?.interactor?.forgottenPassword(request: Login.ForgottenPasswordAction.Request(email: email))
        }
    }
}

extension LoginViewController: LoginPresenterOutput {
    func presenter(didSucceedLogin viewModel: Login.LoginAction.ViewModel.Success) {
        router?.showMainFlow()
    }

    func presenter(didFailLogin viewModel: Login.LoginAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }

    func presenter(didSucceedForgottenPassword viewModel: Login.ForgottenPasswordAction.ViewModel.Success) {
        showAlert(title: viewModel.title,
                  message: viewModel.message)
    }

    func presenter(didFailForgottenPassword viewModel: Login.ForgottenPasswordAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
