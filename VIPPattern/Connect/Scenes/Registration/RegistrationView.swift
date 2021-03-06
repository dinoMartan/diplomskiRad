//
//  RegistrationView.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import SnapKit
import UIKit

class RegistrationView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.openSansExtraBold, size: 34)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.text = "Registration"
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.systemBackground.cgColor
        imageView.layer.cornerRadius = 150 / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    let usernameTextFieldView = CTextFieldView(placeholder: "Username",
                                               textContentType: .username,
                                               backgroundColor: .systemBackground)

    let firstNameTextFieldView = CTextFieldView(placeholder: "First name",
                                                textContentType: .name,
                                                backgroundColor: .systemBackground)

    let lastNameTextFieldView = CTextFieldView(placeholder: "Last name",
                                               textContentType: .familyName,
                                               backgroundColor: .systemBackground)

    let emailTextFieldView = CTextFieldView(placeholder: "Email",
                                            textContentType: .emailAddress,
                                            backgroundColor: .systemBackground)

    let passwordTextFieldView = CTextFieldView(placeholder: "Password",
                                               textContentType: .password,
                                               backgroundColor: .systemBackground,
                                               isSecureText: true)

    private let registerButton = CButtonView(title: "Register")

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()

    var imageTapInteraction: (() -> Void)?
    var registerButtonTapInteraction: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegistrationView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        addSubviews()
        setupCoinstraints()
        setupActions()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(stackView)
        stackView.addArrangedSubview(usernameTextFieldView)
        stackView.addArrangedSubview(firstNameTextFieldView)
        stackView.addArrangedSubview(lastNameTextFieldView)
        stackView.addArrangedSubview(emailTextFieldView)
        stackView.addArrangedSubview(passwordTextFieldView)
        stackView.addArrangedSubview(registerButton)
    }

    private func setupCoinstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.width.height.equalTo(150)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
}

extension RegistrationView {
    private func setupActions() {
        setupLoginButtonAction()
        setupImageTapAction()
    }

    private func setupLoginButtonAction() {
        registerButton.buttonAction = { [weak self] in
            self?.registerButtonTapInteraction?()
        }
    }

    private func setupImageTapAction() {
        let guesture = UITapGestureRecognizer(target: self,
                                              action: #selector(didTapImage))
        imageView.addGestureRecognizer(guesture)
    }

    @objc
    private func didTapImage() {
        imageTapInteraction?()
    }
}
