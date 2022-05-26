 //
//  ProfileView.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import SnapKit
import UIKit

class ProfileView: UIView {
    

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

extension ProfileView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
    }

    private func addSubviews() {
    }

    private func setupCoinstraints() {
    }
}
