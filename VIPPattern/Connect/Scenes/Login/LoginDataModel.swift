//
//  LoginDataModels.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct Login { }

// MARK: LoginAction
extension Login {
    struct LoginAction {
        struct Request {
            let email: String
            let password: String
        }

        struct Response: Equatable {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError?
            }
        }

        struct ViewModel {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError?
            }
        }
    }
}

// MARK: ForgottenPasswordAction
extension Login {
    struct ForgottenPasswordAction {
        struct Request {
            let email: String
        }

        struct Response: Equatable {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError?
            }
        }

        struct ViewModel {
            struct Success: Equatable {
                let title: String
                let message: String
            }

            struct Failure: Equatable {
                let myError: MyError?
            }
        }
    }
}
