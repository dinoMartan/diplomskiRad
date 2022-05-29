//
//  LoginDataModels.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct Login {
    struct ResponseFailure {
        let myError: MyError
    }

    struct ViewModelFailure {
        let myError: MyError
    }
}

// MARK: LoginAction
extension Login {
    struct LoginAction {
        struct Request {
            let email: String?
            let password: String?
        }

        struct ResponseSuccess {
        }

        struct ViewModelSuccess {
        }
    }
}

// MARK: ForgottenPasswordAction
extension Login {
    struct ForgottenPasswordAction {
        struct Request {
            let email: String?
        }

        struct ResponseSuccess {
        }

        struct ViewModelSuccess {
            let title: String
            let message: String
        }
    }
}
