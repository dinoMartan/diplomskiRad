 //
//  MyProjectsView.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import SnapKit
import UIKit

class MyProjectsView: UIView {
    private lazy var addProjectButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapNewProjectButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()

    var addProjectButtonAction: (() -> Void)?
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

extension MyProjectsView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
        backgroundColor = .systemBackground
    }

    private func addSubviews() {
        addSubview(addProjectButton)
    }

    private func setupCoinstraints() {
        addProjectButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.width.height.equalTo(30)
        }
    }
}

extension MyProjectsView {
    @objc
    private func didTapNewProjectButton() {
        addProjectButtonAction?()
    }
}
