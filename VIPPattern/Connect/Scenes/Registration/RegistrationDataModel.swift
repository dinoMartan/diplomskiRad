//
//  RegistrationDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import UIKit

struct Registration {
    struct ResponseFailure {
        let myError: MyError
    }

    struct ViewModelFailure {
        let myError: MyError
    }
}

// MARK: RegisterAction
extension Registration {
    struct RegisterAction {
        struct Request {
            let username: String?
            let firstName: String?
            let lastName: String?
            let email: String?
            let password: String?
            let image: UIImage?
        }

        struct ResponseSuccess {
        }

        struct ViewModelSuccess {
        }
    }
}
