//
//  LoginView.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import SnapKit
import UIKit

class LoginView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Connect")
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.openSansExtraBold, size: 34)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Prijava"
        return label
    }()

    let emailTextFieldView = CTextFieldView(placeholder: "Email",
                                            textContentType: .emailAddress)

    let passwordTextFieldView = CTextFieldView(placeholder: "Lozinka",
                                               textContentType: .password,
                                               isSecureText: true)

    let loginButtonView = CButtonView(title: "Prijava")

    let registerButtonView = CButtonView(title: "Registracija")

    let forgottenPasswordButtonView = CButtonView(title: "Zaboravljena lozinka")

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
        addSubviews()
        setupCoinstraints()
        setupActions()
    }

    private func addSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(emailTextFieldView)
        addSubview(passwordTextFieldView)
        addSubview(loginButtonView)
        addSubview(registerButtonView)
        addSubview(forgottenPasswordButtonView)
    }

    private func setupCoinstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        emailTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }

        passwordTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(emailTextFieldView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }

        loginButtonView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextFieldView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }

        registerButtonView.snp.makeConstraints { make in
            make.top.equalTo(loginButtonView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }

        forgottenPasswordButtonView.snp.makeConstraints { make in
            make.top.equalTo(registerButtonView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(80)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-40).priority(.low)
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
        loginButtonView.buttonAction = { [weak self] in
            self?.loginButtonTapInteraction?()
        }
    }

    private func setupRegisterButtonAction() {
        registerButtonView.buttonAction = { [weak self] in
            self?.registerButtonTapInteraction?()
        }
    }

    private func setupForgottenPasswordButtonAction() {
        forgottenPasswordButtonView.buttonAction = { [weak self] in
            self?.forgottenPasswordButtonTapInteraction?()
        }
    }
}
