//
//  RegistrationView.swift
//  VIPPattern
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
        addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(registerButton)
    }
    
    private func setupCoinstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
    }
}

extension RegistrationView {
    private func setupActions() {
        setupLoginButtonAction()
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
}
