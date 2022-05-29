 //
//  ProfileViewController.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import UIKit

protocol ProfilePresenterOutput: AnyObject {
    func presenter(didSucceedGetUserData viewModel: Profile.GetUserDataAction.ViewModelSuccess)
    func presenter(didFail viewModel: Login.ViewModelFailure)
}

class ProfileViewController: UIViewController {
    var profileView: ProfileView?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?

    private var profileViewModel: Profile.GetUserDataAction.ViewModelSuccess? {
        didSet {
            profileView?.tableView.reloadData()
        }
    }

    override func loadView() {
        super.loadView()
        self.view = profileView
        configureTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getUserData(request: Profile.GetUserDataAction.Request())
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
        let section = profileViewModel?.sections[section]
        switch section {
        case .settings(_):
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableViewHeader.identifier) as? ProfileTableViewHeader
            view?.delegate = self
            view?.setupWith(image: profileViewModel?.baseInfo.profileImage,
                            label: profileViewModel?.baseInfo.displayName)
            return view
        default: return nil
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let section = profileViewModel?.sections[indexPath.section]
        switch section {
        case .settings(let settings):
            let setting = settings[indexPath.row]
            let editAction = UIContextualAction(style: .normal,
                                                title: "Uredi") { [weak self] _, _, completion in
                self?.editSetting(setting)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [editAction])
        default: return nil
        }
    }

    private func editSetting(_ setting: Profile.GetUserDataAction.Setting) {
        showAlertControllerWithTextField(title: "Uredi", message: nil, placeholder: setting.value) { [weak self] newValue in
            var newSetting = setting
            newSetting.value = newValue
            self?.interactor?.updateSetting(request: Profile.UpdateSettingAction.Request(setting: newSetting))
        }
    }
}

extension ProfileViewController: ProfileTableViewHeaderDelegate {
    func didTapProfileImage() {
        ImagePickerManager().pickImage(self) { [weak self] newImage in
            let profileSetting = Profile.GetUserDataAction.Setting(value: nil,
                                                                   icon: nil,
                                                                   type: .image(newImage))
            self?.interactor?.updateSetting(request: Profile.UpdateSettingAction.Request(setting: profileSetting))
        }
    }
}

extension ProfileViewController: ProfilePresenterOutput {
    func presenter(didSucceedGetUserData viewModel: Profile.GetUserDataAction.ViewModelSuccess) {
        self.profileViewModel = viewModel
    }

    func presenter(didFail viewModel: Login.ViewModelFailure) {
        showMyErrorAlert(viewModel.myError)
    }
}
