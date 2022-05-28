//
//  AuthenticationService.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import FirebaseAuth
import Foundation

protocol AuthenticationServiceProtocol {
    func signInUser(email: String, password: String, completion: @escaping ((Result<AuthDataResult, MyError>) -> Void))
    func registerUser(email: String, password: String, completion: @escaping ((Result<AuthDataResult, MyError>) -> Void))
    func sendResetPasswordEmail(email: String, completion: @escaping ((Result<Void, MyError>) -> Void))
}

class AuthenticationService: AuthenticationServiceProtocol {
    private let authentication: Auth

    init() {
        authentication = Auth.auth()
    }

    func registerUser(email: String, password: String, completion: @escaping ((Result<AuthDataResult, MyError>) -> Void)) {
        authentication.createUser(withEmail: email, password: password) { authDataResult, error in
            guard let authDataResult = authDataResult,
                  error == nil else {
                completion(.failure(MyError(type: .registrationFailed, message: error?.localizedDescription)))
                return
            }
            completion(.success(authDataResult))
        }
    }

    func signInUser(email: String, password: String, completion: @escaping ((Result<AuthDataResult, MyError>) -> Void)) {
        authentication.signIn(withEmail: email, password: password) { authDataResult, error in
            guard let authDataResult = authDataResult,
                  error == nil else {
                completion(.failure(MyError(type: .registrationFailed, message: error?.localizedDescription)))
                return
            }
            completion(.success(authDataResult))
        }
    }

    func sendResetPasswordEmail(email: String, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        authentication.sendPasswordReset(withEmail: email) { error in
            guard let error = error else {
                completion(.success(()))
                return
            }
            completion(.failure(MyError(type: .passwordResetFailed, message: error.localizedDescription)))
        }
    }
}
