 //
//  ProfileViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect

class ProfileViewControllerMock {
    var didSucceedGetUserDataCalled = false
    var didSucceedGetUserDataCounter = 0
    var didSucceedGetUserDataViewModel: Profile.GetUserDataAction.ViewModel.Success?

    var didFailGetUserDataCalled = false
    var didFailGetUserDataCounter = 0
    var didFailGetUserDataViewModel: Profile.GetUserDataAction.ViewModel.Failure?

    var didSucceedUpdateSettingCalled = false
    var didSucceedUpdateSettingCounter = 0
    var didSucceedUpdateSettingViewModel: Profile.UpdateSettingAction.ViewModel.Success?

    var didFailUpdateSettingCalled = false
    var didFailUpdateSettingCounter = 0
    var didFailUpdateSettingViewModel: Profile.UpdateSettingAction.ViewModel.Failure?
}

extension ProfileViewControllerMock: ProfilePresenterOutput {
    func presenter(didSucceedGetUserData viewModel: Profile.GetUserDataAction.ViewModel.Success) {
        didSucceedGetUserDataCalled = true
        didSucceedGetUserDataCounter += 1
        didSucceedGetUserDataViewModel = viewModel
    }

    func presenter(didFailGetUserData viewModel: Profile.GetUserDataAction.ViewModel.Failure) {
        didFailGetUserDataCalled = true
        didFailGetUserDataCounter += 1
        didFailGetUserDataViewModel = viewModel
    }

    func presenter(didSucceedUpdateSetting viewModel: Profile.UpdateSettingAction.ViewModel.Success) {
        didSucceedUpdateSettingCalled = true
        didSucceedUpdateSettingCounter += 1
        didSucceedUpdateSettingViewModel = viewModel
    }

    func presenter(didFailUpdateSettingData viewModel: Profile.UpdateSettingAction.ViewModel.Failure) {
        didFailUpdateSettingCalled = true
        didFailUpdateSettingCounter += 1
        didFailUpdateSettingViewModel = viewModel
    }
}
