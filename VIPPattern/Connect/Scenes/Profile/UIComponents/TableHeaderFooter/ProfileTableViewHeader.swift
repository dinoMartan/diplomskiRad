//
//  ProfileTableViewHeader.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import UIKit

protocol ProfileTableViewHeaderDelegate: AnyObject {
    func didTapProfileImage()
}

class ProfileTableViewHeader: UITableViewHeaderFooterView {
    static let identifier = "ProfileTableViewHeader"

    weak var delegate: ProfileTableViewHeaderDelegate?

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

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
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
        setupAction()
    }

    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(displayNameLabel)
    }

    private func setupCoinstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
        }

        stackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    private func setupAction() {
        let guesture = UITapGestureRecognizer(target: self,
                                              action: #selector(didTapProfileImage))
        imageView.addGestureRecognizer(guesture)
    }

    @objc
    private func didTapProfileImage() {
        delegate?.didTapProfileImage()
    }
}
