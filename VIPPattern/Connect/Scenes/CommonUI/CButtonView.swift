//
//  CButtonView.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import UIKit

class CButtonView: UIView {
    private lazy var button: UIButton = {
        let button = UIButton()
        let guesture = UITapGestureRecognizer(target: self,
                                              action: #selector(didTapButton))
        button.addGestureRecognizer(guesture)
        button.backgroundColor = .secondaryLabel
        return button
    }()

    var buttonAction: (() -> Void)?

    init(title: String?) {
        super.init(frame: .zero)
        setupView()
        button.setTitle(title, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CButtonView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
    }

    private func addSubviews() {
        addSubview(button)
    }

    private func setupCoinstraints() {
        button.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension CButtonView {
    @objc
    private func didTapButton() {
        buttonAction?()
    }
}
