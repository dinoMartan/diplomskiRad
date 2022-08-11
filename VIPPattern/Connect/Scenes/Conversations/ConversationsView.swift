 //
//  ConversationsView.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import SnapKit
import UIKit

class ConversationsView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
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

extension ConversationsView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
    }

    private func addSubviews() {
        addSubview(tableView)
    }

    private func setupCoinstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
