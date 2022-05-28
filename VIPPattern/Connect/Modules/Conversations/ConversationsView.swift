 //
//  ConversationsView.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import SnapKit
import UIKit

class ConversationsView: UIView {
    

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

extension ConversationsView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
        backgroundColor = .systemPink
    }

    private func addSubviews() {
    }

    private func setupCoinstraints() {
    }
}
