 //
//  ProfilePresenter.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation
import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    func interactor(didFetchUser user: User)
    func interactor(didFail myError: MyError)
}

struct ProfileViewModel {
    let baseInfo: ProfileViewModelBaseInfo
    let sections: [ProfileViewModelSection]
}

struct ProfileViewModelBaseInfo {
    let userId: String?
    let displayName: String?
    let profileImage: String?
}

enum ProfileViewModelSection {
    case settings(_ settings: [ProfileViewModelSetting])
}

struct ProfileViewModelSetting {
    var value: String?
    let icon: String?
    let type: ProfileViewModelSettingType
}

enum ProfileViewModelSettingType {
    case firstName
    case lastName
    case username
    case image(_ image: UIImage?)
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var viewController: ProfilePresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didFetchUser user: User) {
        let baseInfo = ProfileViewModelBaseInfo(userId: user.id,
                                                displayName: user.username,
                                                profileImage: user.profileImage)
        let sections = [
            ProfileViewModelSection.settings([
                ProfileViewModelSetting(value: user.firstName, icon: "person", type: .firstName),
                ProfileViewModelSetting(value: user.lastName, icon: "person", type: .lastName),
                ProfileViewModelSetting(value: user.username, icon: "person", type: .username)
            ])
        ]
        let profileViewModel = ProfileViewModel(baseInfo: baseInfo,
                                                sections: sections)
        viewController?.presenter(didFetchUserData: profileViewModel)
    }

    func interactor(didFail myError: MyError) {
        //
    }
}
