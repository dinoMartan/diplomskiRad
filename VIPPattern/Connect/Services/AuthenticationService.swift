//
//  AuthenticationService.swift
//  Connect
//
//  Created by Dino Martan on 07.08.2022..
//

import FirebaseAuth
import Foundation

protocol AuthenticationServiceProtocol {
    func registerUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void))
    func signInUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void))
    func sendResetPasswordEmail(email: String, completion: @escaping ((Result<Void, MyError>) -> Void))
}

class AuthenticationService: AuthenticationServiceProtocol {
    private let authentication: Auth

    init() {
        authentication = Auth.auth()
    }

    func registerUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        authentication.createUser(withEmail: email, password: password) { authDataResult, error in
            guard let authDataResult = authDataResult,
                  error == nil else {
                completion(.failure(MyError(type: .registrationFailed, message: error?.localizedDescription)))
                return
            }
            let authenticationResponse = AuthenticationResponse(userId: authDataResult.user.uid)
            completion(.success(authenticationResponse))
        }
    }

    func signInUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        authentication.signIn(withEmail: email, password: password) { authDataResult, error in
            guard let authDataResult = authDataResult,
                  error == nil else {
                completion(.failure(MyError(type: .registrationFailed, message: error?.localizedDescription)))
                return
            }
            let authenticationResponse = AuthenticationResponse(userId: authDataResult.user.uid)
            completion(.success(authenticationResponse))
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
