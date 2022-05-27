//
//  ProfileTableViewHeader.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import UIKit

class ProfileTableViewHeader: UITableViewHeaderFooterView {
    static let identifier = "ProfileTableViewHeader"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.systemFill.cgColor
        imageView.layer.cornerRadius = 150 / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWith(image: String?, label: String?) {
        imageView.setImageFromFireStore(image ?? "")
        displayNameLabel.text = label
    }
}

extension ProfileTableViewHeader {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
    }

    private func addSubviews() {
        addSubview(imageView)
        addSubview(displayNameLabel)
    }

    private func setupCoinstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.width.height.equalTo(150)
            make.centerX.equalToSuperview()
        }

        displayNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
