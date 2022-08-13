 //
//  ProfilePresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect

class ProfilePresenterMock {
    var didSucceedGetUserDataCalled = false
    var didSucceedGetUserDataCounter = 0
    var didSucceedGetUserDataResponse: Profile.GetUserDataAction.Response.Success?

    var didFailGetUserDataCalled = false
    var didFailGetUserDataCounter = 0
    var didFailGetUserDataResponse: Profile.GetUserDataAction.Response.Failure?

    var didSucceedUpdateSettingCalled = false
    var didSucceedUpdateSettingCounter = 0
    var didSucceedUpdateSettingResponse: Profile.UpdateSettingAction.Response.Success?

    var didFailUpdateSettingCalled = false
    var didFailUpdateSettingCounter = 0
    var didFailUpdateSettingResponse: Profile.UpdateSettingAction.Response.Failure?

    var didSucceedSignOutCalled = false
    var didSucceedSignOutCounter = 0
    var didSucceedSignOutResponse: Profile.SignOutAction.Response.Success?

    var didFailSignOutCalled = false
    var didFailSignOutCounter = 0
    var didFailSignOutResponse: Profile.SignOutAction.Response.Failure?
}

extension ProfilePresenterMock: ProfilePresenterProtocol {
    func interactor(didSucceedGetUserData response: Profile.GetUserDataAction.Response.Success) {
        didSucceedGetUserDataCalled = true
        didSucceedGetUserDataCounter += 1
        didSucceedGetUserDataResponse = response
    }

    func interactor(didFailGetUserData response: Profile.GetUserDataAction.Response.Failure) {
        didFailGetUserDataCalled = true
        didFailGetUserDataCounter += 1
        didFailGetUserDataResponse = response
    }

    func interactor(didSucceedUpdateSetting response: Profile.UpdateSettingAction.Response.Success) {
        didSucceedUpdateSettingCalled = true
        didSucceedUpdateSettingCounter += 1
        didSucceedUpdateSettingResponse = response
    }

    func interactor(didFailUpdateSetting response: Profile.UpdateSettingAction.Response.Failure) {
        didFailUpdateSettingCalled = true
        didFailUpdateSettingCounter += 1
        didFailUpdateSettingResponse = response
    }

    func interactor(didSucceedSignOut response: Profile.SignOutAction.Response.Success) {
        didSucceedSignOutCalled = true
        didSucceedSignOutCounter += 1
        didSucceedSignOutResponse = response
    }

    func interactor(didFailSignOut response: Profile.SignOutAction.Response.Failure) {
        didFailSignOutCalled = true
        didFailSignOutCounter += 1
        didFailSignOutResponse = response
    }
}
