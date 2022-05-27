 //
//  EditProjectView.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import SnapKit
import UIKit

class EditProjectView: UIView {
    

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

extension EditProjectView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
        backgroundColor = .systemGreen
    }

    private func addSubviews() {
    }

    private func setupCoinstraints() {
    }
}
