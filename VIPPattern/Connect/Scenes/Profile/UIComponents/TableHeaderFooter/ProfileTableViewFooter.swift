//
//  ProfileTableViewFooter.swift
//  Connect
//
//  Created by Dino Martan on 12.08.2022..
//

import UIKit

protocol ProfileTableViewFooterDelegate: AnyObject {
    func didTapLogoutButton()
}

class ProfileTableViewFooter: UITableViewHeaderFooterView {
    static let identifier = "ProfileTableViewFooter"

    weak var delegate: ProfileTableViewFooterDelegate?

    private let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Odjava", for: .normal)
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileTableViewFooter {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
    }

    private func addSubviews() {
        addSubview(logoutButton)
    }

    private func setupCoinstraints() {
        logoutButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
