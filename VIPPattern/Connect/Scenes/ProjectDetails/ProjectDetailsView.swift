 //
//  ProjectDetailsView.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import SnapKit
import UIKit

class ProjectDetailsSubview: UIView {
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.font = UIFont(.openSansExtraBold, size: 20)
        return label
    }()

    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(.openSansMedium, size: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupIconAndTitle(icon: String, title: String) {
        iconImageView.image = UIImage(systemName: icon)
        titleLabel.text = title
    }

    func setupTextWith(_ text: String) {
        textLabel.text = text
    }
}

extension ProjectDetailsSubview {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
        backgroundColor = .systemBackground
        self.setShadowAndCornerRadius()
    }

    private func addSubviews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(textLabel)
    }

    private func setupCoinstraints() {
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(20)
        }

        textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(iconImageView.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}

class ProjectDetailsView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    let projectTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(.openSansExtraBold, size: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Project title"
        return label
    }()

    let ownerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()

    let ownerName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(.openSansExtraBold, size: 24)
        label.textColor = .label
        label.text = "owner name"
        return label
    }()

    let ownerUsername: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(.openSansMedium, size: 16)
        label.textColor = .secondaryLabel
        label.text = "owner username"
        return label
    }()

    let projectDescriptionView = ProjectDetailsSubview()
    let needTagsView = ProjectDetailsSubview()
    let haveTagsView = ProjectDetailsSubview()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProjectDetailsView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
        setupSubviews()
    }

    private func setupSubviews() {
        projectDescriptionView.setupIconAndTitle(icon: "scribble.variable", title: "Project description")
        needTagsView.setupIconAndTitle(icon: "target", title: "Project needs")
        haveTagsView.setupIconAndTitle(icon: "checkmark.circle", title: "Project has")
    }

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(projectTitle)
        contentView.addSubview(ownerImageView)
        contentView.addSubview(ownerName)
        contentView.addSubview(ownerUsername)
        contentView.addSubview(projectDescriptionView)
        contentView.addSubview(haveTagsView)
        contentView.addSubview(needTagsView)
    }

    private func setupCoinstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }

        projectTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-15)
        }

        ownerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(projectTitle.snp.bottom).offset(25)
        }

        ownerName.snp.makeConstraints { make in
            make.leading.equalTo(ownerImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(projectTitle.snp.bottom).offset(25)
            make.height.equalTo(20).priority(.medium)
        }

        ownerUsername.snp.makeConstraints { make in
            make.leading.equalTo(ownerImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(ownerName.snp.bottom)
            make.height.equalTo(20).priority(.medium)
        }

        projectDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(ownerImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }

        needTagsView.snp.makeConstraints { make in
            make.top.equalTo(projectDescriptionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }

        haveTagsView.snp.makeConstraints { make in
            make.top.equalTo(needTagsView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
