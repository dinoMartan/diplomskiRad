//
//  MyError.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

struct MyError: Error {
    let type: MyErrorType?
    let message: String?

    func getMessage() -> String {
        guard let message = message else {
            switch type {
                case .registrationFailed: return "Registracija neuspješna!"
                case .emailOrPasswordFieldEmpty: return "Email ili lozinka nisu uneseni"
                case .signInFailed: return "Prijava neuspješna!"
                case .passwordResetFailed: return "Došlo je do greške kod resetiranja lozinke"
                default: return "Došlo je do greške"
            }
        }
        return message
    }
}

enum MyErrorType {
    case registrationFailed
    case signInFailed
    case emailOrPasswordFieldEmpty
    case passwordResetFailed
    case firestoreFailed
    case codableError
}
