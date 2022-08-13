//
//  RegistrationView.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import SnapKit
import UIKit

class RegistrationView: UIView {
    private let scrollView = UIScrollView()
    private let containerView = UIView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.openSansExtraBold, size: 34)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.text = "Registracija"
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

    let usernameTextFieldView = CTextFieldView(placeholder: "Korisničko ime",
                                               textContentType: .username,
                                               backgroundColor: .systemBackground)

    let firstNameTextFieldView = CTextFieldView(placeholder: "Ime",
                                                textContentType: .name,
                                                backgroundColor: .systemBackground)

    let lastNameTextFieldView = CTextFieldView(placeholder: "Prezime",
                                               textContentType: .familyName,
                                               backgroundColor: .systemBackground)

    let emailTextFieldView = CTextFieldView(placeholder: "Email",
                                            textContentType: .emailAddress,
                                            backgroundColor: .systemBackground)

    let passwordTextFieldView = CTextFieldView(placeholder: "Lozinka",
                                               textContentType: .password,
                                               backgroundColor: .systemBackground,
                                               isSecureText: true)

    private let registerButton = CButtonView(title: "Registriraj se")

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
        addSubviews()
        setupCoinstraints()
        setupActions()
        setBackgroundColor()
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(imageView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(usernameTextFieldView)
        stackView.addArrangedSubview(firstNameTextFieldView)
        stackView.addArrangedSubview(lastNameTextFieldView)
        stackView.addArrangedSubview(emailTextFieldView)
        stackView.addArrangedSubview(passwordTextFieldView)
        stackView.addArrangedSubview(registerButton)
    }

    private func setupCoinstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }

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
            make.bottom.equalToSuperview().offset(-20)
        }

        usernameTextFieldView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
    }

    private func setBackgroundColor() {
        backgroundColor = .secondarySystemBackground
        scrollView.backgroundColor = .secondarySystemBackground
        containerView.backgroundColor = .secondarySystemBackground
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
