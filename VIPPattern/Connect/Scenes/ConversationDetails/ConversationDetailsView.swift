 //
//  ConversationDetailsView.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import SnapKit
import UIKit

class ConversationDetailsView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    private let sendingView: UIView = {
        let view = UIView()
        return view
    }()

    let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()

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

extension ConversationDetailsView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
        backgroundColor = .systemGreen
    }

    private func addSubviews() {
        addSubview(tableView)
        addSubview(sendingView)
        sendingView.addSubview(textField)
    }

    private func setupCoinstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }

        sendingView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        textField.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(5)
            make.trailing.bottom.equalToSuperview().offset(-5)
        }
    }
}
