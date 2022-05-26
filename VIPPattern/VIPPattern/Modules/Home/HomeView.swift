 //
//  HomeView.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import SnapKit
import UIKit

class HomeView: UIView {
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
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

extension HomeView {
    private func setupView() {
        addSubviews()
        setupCoinstraints()
    }

    private func addSubviews() {
        addSubview(searchBar)
        addSubview(tableView)
    }

    private func setupCoinstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
