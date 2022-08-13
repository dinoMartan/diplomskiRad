 //
//  ProfilePresenter.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func interactor(didSucceedGetUserData response: Profile.GetUserDataAction.Response.Success)
    func interactor(didFailGetUserData response: Profile.GetUserDataAction.Response.Failure)
    func interactor(didSucceedUpdateSetting response: Profile.UpdateSettingAction.Response.Success)
    func interactor(didFailUpdateSetting response: Profile.UpdateSettingAction.Response.Failure)
    func interactor(didSucceedSignOut response: Profile.SignOutAction.Response.Success)
    func interactor(didFailSignOut response: Profile.SignOutAction.Response.Failure)
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var viewController: ProfilePresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedGetUserData response: Profile.GetUserDataAction.Response.Success) {
        let settings = [
                Profile.Setting(value: response.user.firstName, icon: "person", type: .firstName),
                Profile.Setting(value: response.user.lastName, icon: "person", type: .lastName),
                Profile.Setting(value: response.user.username, icon: "person", type: .username)
            ]
        let viewModelSuccess = Profile.GetUserDataAction.ViewModel.Success(userId: response.user.id ?? "",
                                                                           displayName: response.user.username ?? "",
                                                                           profileImage: response.user.profileImage ?? "",
                                                                           settings: settings)
        viewController?.presenter(didSucceedGetUserData: viewModelSuccess)
    }

    func interactor(didFailGetUserData response: Profile.GetUserDataAction.Response.Failure) {
        let viewModel = Profile.GetUserDataAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailGetUserData: viewModel)
    }

    func interactor(didSucceedUpdateSetting response: Profile.UpdateSettingAction.Response.Success) {
        let viewModel = Profile.UpdateSettingAction.ViewModel.Success()
        viewController?.presenter(didSucceedUpdateSetting: viewModel)
    }

    func interactor(didFailUpdateSetting response: Profile.UpdateSettingAction.Response.Failure) {
        let viewModel = Profile.UpdateSettingAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailUpdateSettingData: viewModel)
    }

    func interactor(didSucceedSignOut response: Profile.SignOutAction.Response.Success) {
        let viewModel = Profile.SignOutAction.ViewModel.Success()
        viewController?.presenter(didSucceedSignOut: viewModel)
    }

    func interactor(didFailSignOut response: Profile.SignOutAction.Response.Failure) {
        let viewModel = Profile.SignOutAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailSignOut: viewModel)
    }
}
