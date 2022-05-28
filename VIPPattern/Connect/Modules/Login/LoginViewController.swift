//
//  LoginViewController.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import UIKit

protocol LoginPresenterOutput: AnyObject {
    func presenterDidSucceedLogin()
    func presenter(didSucceedSendForgottenPasswordEmail title: String, message: String)
    func presenter(didFail myError: MyError)
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        router?.shouldClose()
    }

    deinit {
        print("deinit \(self)")
    }
}

extension LoginViewController {
    private func setupInteractions() {
        loginView?.loginButtonTapInteraction = { [weak self] in
            self?.interactor?.loginUser(email: self?.loginView?.emailTextField.text,
                                        password: self?.loginView?.passwordTextField.text)
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
            self?.interactor?.sendResetPasswordEmail(email: email)
        }
    }
}

extension LoginViewController: LoginPresenterOutput {
    func presenterDidSucceedLogin() {
        router?.showMainFlow()
    }

    func presenter(didSucceedSendForgottenPasswordEmail title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    func presenter(didFail myError: MyError) {
        showMyErrorAlert(myError)
    }
}
