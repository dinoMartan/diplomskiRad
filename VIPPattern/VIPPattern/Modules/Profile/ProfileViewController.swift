 //
//  ProfileViewController.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import UIKit

protocol ProfilePresenterOutput: AnyObject {
    func presenter(didFetchUserData profileViewModel: ProfileViewModel)
}

class ProfileViewController: UIViewController {
    var profileView: ProfileView?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?

    private var profileViewModel: ProfileViewModel? {
        didSet {
            profileView?.tableView.reloadData()
        }
    }

    override func loadView() {
        super.loadView()
        self.view = profileView
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getUserData()
    }

    deinit {
        router?.shouldClose()
        print("deinit \(self)")
    }
}

extension ProfileViewController {
    private func configureTableView() {
        profileView?.tableView.dataSource = self
        profileView?.tableView.delegate = self
        profileView?.tableView.register(UINib.init(nibName: ProfileSettingTableViewCell.identifier,
                                                   bundle: nil),
                                        forCellReuseIdentifier: ProfileSettingTableViewCell.identifier)
        profileView?.tableView.register(ProfileTableViewHeader.self,
                                        forHeaderFooterViewReuseIdentifier: ProfileTableViewHeader.identifier)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        profileViewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = profileViewModel?.sections[section]
        switch section {
        case .settings(let settings):
            return settings.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = profileViewModel?.sections[indexPath.section]
        switch section {
        case .settings(let settings):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingTableViewCell.identifier, for: indexPath) as? ProfileSettingTableViewCell
            else { return UITableViewCell() }
            cell.setupWith(settings[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableViewHeader.identifier) as? ProfileTableViewHeader
        view?.setupWith(image: profileViewModel?.baseInfo.profileImage,
                        label: profileViewModel?.baseInfo.displayName)
        return view
    }
}

extension ProfileViewController: ProfilePresenterOutput {
    func presenter(didFetchUserData profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
    }
}
