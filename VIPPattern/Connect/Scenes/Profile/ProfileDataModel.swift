//
//  ProfileDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import UIKit

struct Profile {
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

// MARK: GetUserDataAction
extension Profile {
    struct GetUserDataAction {
        struct Request { }

        struct Response {
            struct Success {
                let user: User
            }

            struct Failure {
                let myError: MyError
            }
        }

        struct ViewModel {
            struct Success {
                let userId: String
                let displayName: String
                let profileImage: String
                let settings: [Setting]
            }

            struct Failure {
                let myError: MyError
            }
        }
    }
}

// MARK: UpdateSettingAction
extension Profile {
    struct UpdateSettingAction {
        struct Request {
            let setting: Profile.Setting
        }

        struct Response {
            struct Success { }

            struct Failure {
                let myError: MyError
            }
        }

        struct ViewModel {
            struct Success { }

            struct Failure {
                let myError: MyError
            }
        }
    }
}
