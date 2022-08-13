 //
//  ProfileDataModelMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect
import UIKit

struct ProfileDataModelMock {
    private static let dataMock = DataMock()
    static let myError = MyError(type: .codableError,
                                         message: "This is message")
    static let firstNameSetting = Profile.Setting(value: ProfileDataModelMock.dataMock.getUser().firstName ?? "", icon: "person", type: .firstName)
    static let lastNameSetting = Profile.Setting(value: ProfileDataModelMock.dataMock.getUser().lastName ?? "", icon: "person", type: .lastName)
    static let usernameSetting = Profile.Setting(value: ProfileDataModelMock.dataMock.getUser().username ?? "", icon: "person", type: .username)
    let getUserDataAction = ProfileDataModelMock.GetUserDataAction()
    let updateSettingAction = ProfileDataModelMock.UpdateSettingAction()
    let signOutAction = ProfileDataModelMock.SignOutAction()
}

extension ProfileDataModelMock {
    struct GetUserDataAction {
        let request = Profile.GetUserDataAction.Request()
        let responseSuccess = Profile.GetUserDataAction.Response.Success(user: ProfileDataModelMock.dataMock.getUser())
        let responseFailure = Profile.GetUserDataAction.Response.Failure(myError: myError)
        let viewModelSuccess = Profile.GetUserDataAction.ViewModel.Success(userId: ProfileDataModelMock.dataMock.getUser().id ?? "",
                                                                           displayName: ProfileDataModelMock.dataMock.getUser().username ?? "",
                                                                           profileImage: ProfileDataModelMock.dataMock.getUser().profileImage ?? "",
                                                                           settings: [firstNameSetting, lastNameSetting, usernameSetting])
        let viewModelFailure = Profile.GetUserDataAction.ViewModel.Failure(myError: myError)
    }
}

extension ProfileDataModelMock {
    struct UpdateSettingAction {
        let request = Profile.UpdateSettingAction.Request(setting: firstNameSetting)
        let responseSuccess = Profile.UpdateSettingAction.Response.Success()
        let responseFailure = Profile.UpdateSettingAction.Response.Failure(myError: myError)
        let viewModelSuccess = Profile.UpdateSettingAction.ViewModel.Success()
        let viewModelFailure = Profile.UpdateSettingAction.ViewModel.Failure(myError: myError)
    }
}

extension ProfileDataModelMock {
    struct SignOutAction {
        let request = Profile.SignOutAction.Request()
        let responseSuccess = Profile.SignOutAction.Response.Success()
        let responseFailure = Profile.SignOutAction.Response.Failure(myError: LoginDataModelMock.myError)
        let viewModelSuccess = Profile.SignOutAction.ViewModel.Success()
        let viewModelFailure = Profile.SignOutAction.ViewModel.Failure(myError: LoginDataModelMock.myError)
    }
}
