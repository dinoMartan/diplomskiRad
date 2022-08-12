//
//  ProfileDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import UIKit

struct Profile: Equatable {
    struct Setting: Equatable {
        var value: String?
        let icon: String?
        let type: SettingType
    }

    enum SettingType: Equatable {
        case firstName
        case lastName
        case username
        case image(_ image: UIImage?)
    }
}

// MARK: GetUserDataAction
extension Profile {
    struct GetUserDataAction: Equatable {
        struct Request: Equatable { }

        struct Response: Equatable {
            struct Success: Equatable {
                let user: User
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable {
                let userId: String
                let displayName: String
                let profileImage: String
                let settings: [Setting]
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}

// MARK: UpdateSettingAction
extension Profile {
    struct UpdateSettingAction: Equatable {
        struct Request: Equatable {
            let setting: Profile.Setting
        }

        struct Response: Equatable {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}

// MARK: LogoutAction
extension Profile {
    struct LogoutAction: Equatable {
        struct Request: Equatable { }

        struct Response: Equatable {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}
