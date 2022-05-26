//
//  LoginViewController.swift
//  VIPPattern
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
        let alertController = createForgottenPasswordAlertController { email in
            self.interactor?.sendResetPasswordEmail(email: email)
        }
        present(alertController, animated: true)
    }

    private func createForgottenPasswordAlertController(completion: @escaping ((String?) -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: "Zaboravljena lozinka",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Email"
        }
        setForgottenPasswordAlertActionsFor(alertController, completion: completion)
        return alertController
    }

    private func setForgottenPasswordAlertActionsFor(_ alertController: UIAlertController, completion: @escaping ((String?) -> Void)) {
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            let email = alertController.textFields?.first?.text
            completion(email)
        }
        let cancelAction = UIAlertAction(title: "Odustani", style: .cancel)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
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
