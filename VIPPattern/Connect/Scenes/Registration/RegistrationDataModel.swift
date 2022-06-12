//
//  RegistrationDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import UIKit

struct Registration: Equatable { }

// MARK: RegisterAction
extension Registration {
    struct RegisterAction: Equatable {
        struct Request: Equatable {
            let username: String?
            let firstName: String?
            let lastName: String?
            let email: String?
            let password: String?
            let image: UIImage?
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
