 //
//  ProfileViewController.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import UIKit

protocol ProfilePresenterOutput: AnyObject {
    func presenter(didSucceedGetUserData viewModel: Profile.GetUserDataAction.ViewModel.Success)
    func presenter(didFailGetUserData viewModel: Profile.GetUserDataAction.ViewModel.Failure)
    func presenter(didSucceedUpdateSetting viewModel: Profile.UpdateSettingAction.ViewModel.Success)
    func presenter(didFailUpdateSettingData viewModel: Profile.UpdateSettingAction.ViewModel.Failure)
}

class ProfileViewController: UIViewController {
    var profileView: ProfileView?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?

    private var userData: Profile.GetUserDataAction.ViewModel.Success?

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userData?.settings.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = userData?.settings[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingTableViewCell.identifier, for: indexPath) as? ProfileSettingTableViewCell
        else { return UITableViewCell() }
        cell.setupWith(setting)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableViewHeader.identifier) as? ProfileTableViewHeader
        view?.delegate = self
        view?.setupWith(image: userData?.profileImage,
                        label: userData?.displayName)
        return view
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let setting = userData?.settings[indexPath.row]
        let editAction = UIContextualAction(style: .normal,
                                            title: "Uredi") { [weak self] _, _, completion in
            self?.editSetting(setting)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [editAction])
    }

    private func editSetting(_ setting: Profile.Setting?) {
        guard let setting = setting else {
            return
        }
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
            let profileSetting = Profile.Setting(value: nil,
                                                 icon: nil,
                                                 type: .image(newImage))
            self?.interactor?.updateSetting(request: Profile.UpdateSettingAction.Request(setting: profileSetting))
        }
    }
}

extension ProfileViewController: ProfilePresenterOutput {
    func presenter(didSucceedGetUserData viewModel: Profile.GetUserDataAction.ViewModel.Success) {
        userData = viewModel
        profileView?.tableView.reloadData()
    }

    func presenter(didFailGetUserData viewModel: Profile.GetUserDataAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }

    func presenter(didSucceedUpdateSetting viewModel: Profile.UpdateSettingAction.ViewModel.Success) {
        //
    }

    func presenter(didFailUpdateSettingData viewModel: Profile.UpdateSettingAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
