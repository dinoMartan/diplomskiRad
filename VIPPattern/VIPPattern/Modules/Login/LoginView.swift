//
//  LoginView.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import SnapKit
import UIKit

class LoginView: UIView {
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Email"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textContentType = .password
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Lozinka"
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Prijava", for: .normal)
        return button
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Registracija", for: .normal)
        return button
    }()

    private let forgottenPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Zaboravljena lozinka", for: .normal)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()

    var loginButtonTapInteraction: (() -> Void)?
    var registerButtonTapInteraction: (() -> Void)?
    var forgottenPasswordButtonTapInteraction: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    private func setupView() {
        backgroundColor = .systemGray
        addSubviews()
        setupCoinstraints()
        setupActions()
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
        stackView.addArrangedSubview(forgottenPasswordButton)
    }
    
    private func setupCoinstraints() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
    }
}

extension LoginView {
    private func setupActions() {
        setupLoginButtonAction()
        setupRegisterButtonAction()
        setupForgottenPasswordButtonAction()
    }

    private func setupLoginButtonAction() {
        let guesture = UITapGestureRecognizer(target: self,
                                              action: #selector(didTapLoginButton))
        loginButton.addGestureRecognizer(guesture)
    }

    @objc
    private func didTapLoginButton() {
        loginButtonTapInteraction?()
    }

    private func setupRegisterButtonAction() {
        let guesture = UITapGestureRecognizer(target: self,
                                              action: #selector(didTapRegisterButton))
        registerButton.addGestureRecognizer(guesture)
    }

    @objc
    private func didTapRegisterButton() {
        registerButtonTapInteraction?()
    }

    private func setupForgottenPasswordButtonAction() {
        let guesture = UITapGestureRecognizer(target: self,
                                              action: #selector(didTapForgottenPasswordButton))
        forgottenPasswordButton.addGestureRecognizer(guesture)
    }

    @objc
    private func didTapForgottenPasswordButton() {
        forgottenPasswordButtonTapInteraction?()
    }
}
