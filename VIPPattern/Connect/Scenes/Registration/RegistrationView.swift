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
        label.textAlignment = .center
        label.text = "Registriraj se"
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

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Korisničko ime"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()

    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Ime"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()

    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Prezime"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()

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
        textField.placeholder = "Lozinka"
        textField.backgroundColor = .secondarySystemBackground
        textField.textContentType = .password
        return textField
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Registracija", for: .normal)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 20
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
        backgroundColor = .systemGray
        addSubviews()
        setupCoinstraints()
        setupActions()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
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
        let guesture = UITapGestureRecognizer(target: self,
                                              action: #selector(didTapLoginButton))
        registerButton.addGestureRecognizer(guesture)
    }

    @objc
    private func didTapLoginButton() {
        registerButtonTapInteraction?()
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
