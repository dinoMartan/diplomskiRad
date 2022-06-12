 //
//  ProfilePresenter.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation
import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    func interactor(getUserDataActionSuccess response: Profile.GetUserDataAction.ResponseSuccess)
    func interactor(didFail response: Profile.ResponseFailure)
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var viewController: ProfilePresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(getUserDataActionSuccess response: Profile.GetUserDataAction.ResponseSuccess) {
        let baseInfo = Profile.GetUserDataAction.BaseInfo(userId: response.user.id,
                                                          displayName: response.user.username,
                                                          profileImage: response.user.profileImage)
        let sections = [
            Profile.GetUserDataAction.Section.settings([
                Profile.GetUserDataAction.Setting(value: response.user.firstName, icon: "person", type: .firstName),
                Profile.GetUserDataAction.Setting(value: response.user.lastName, icon: "person", type: .lastName),
                Profile.GetUserDataAction.Setting(value: response.user.username, icon: "person", type: .username)
            ])
        ]
        let viewModelSuccess = Profile.GetUserDataAction.ViewModelSuccess(baseInfo: baseInfo,
                                                                          sections: sections)
        viewController?.presenter(didSucceedGetUserData: viewModelSuccess)
    }

    func interactor(didFail response: Profile.ResponseFailure) {
        viewController?.presenter(didFail: Profile.ViewModelFailure(myError: response.myError))
    }
}
