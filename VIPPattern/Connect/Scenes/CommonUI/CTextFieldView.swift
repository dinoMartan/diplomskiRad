//
//  CTextFieldView.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import UIKit

class CTextFieldView: UIView {
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(.openSansMedium, size: 12)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()

    init(placeholder: String, textContentType: UITextContentType, backgroundColor: UIColor = .secondarySystemBackground, isSecureText: Bool = false) {
        super.init(frame: .zero)
        setupView()
        textField.placeholder = placeholder
        textField.backgroundColor = backgroundColor
        textField.isSecureTextEntry = isSecureText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CTextFieldView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
    }

    private func addSubviews() {
        addSubview(textField)
    }

    private func setupCoinstraints() {
        textField.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
    }
}
