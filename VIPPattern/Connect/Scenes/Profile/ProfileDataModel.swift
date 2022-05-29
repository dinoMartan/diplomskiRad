//
//  ProfileDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import UIKit

struct Profile {
    struct ResponseFailure {
        let myError: MyError
    }

    struct ViewModelFailure {
        let myError: MyError
    }
}

// MARK: GetUserDataAction
extension Profile {
    struct GetUserDataAction {
        struct Request {
        }

        struct ResponseSuccess {
            let user: User
        }

        struct ViewModelSuccess {
            let baseInfo: BaseInfo
            let sections: [Section]
        }

        struct BaseInfo {
            let userId: String?
            let displayName: String?
            let profileImage: String?
        }

        enum Section {
            case settings(_ settings: [Setting])
        }

        struct Setting {
            var value: String?
            let icon: String?
            let type: SettingType
        }

        enum SettingType {
            case firstName
            case lastName
            case username
            case image(_ image: UIImage?)
        }
    }
}

// MARK: UpdateSettingAction
extension Profile {
    struct UpdateSettingAction {
        struct Request {
            let setting: GetUserDataAction.Setting
        }

        struct ResponseSuccess {
        }

        struct ViewModelSuccess {
        }
    }
}
