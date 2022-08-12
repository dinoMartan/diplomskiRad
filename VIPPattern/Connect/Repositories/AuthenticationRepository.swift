//
//  AuthenticationRepository.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

protocol AuthenticationRepositoryProtocol {
    func registerUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void))
    func signInUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void))
    func sendResetPasswordEmail(email: String, completion: @escaping ((Result<Void, MyError>) -> Void))
    func signOut(completion: @escaping ((Result<Void, MyError>) -> Void))
}

class AuthenticationRepository: AuthenticationRepositoryProtocol {
    private let authenticationService: AuthenticationServiceProtocol

    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }

    func registerUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        authenticationService.registerUser(email: email, password: password, completion: completion)
    }

    func signInUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        authenticationService.signInUser(email: email, password: password, completion: completion)
    }

    func sendResetPasswordEmail(email: String, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        authenticationService.sendResetPasswordEmail(email: email, completion: completion)
    }

    func signOut(completion: @escaping ((Result<Void, MyError>) -> Void)) {
        authenticationService.signOut(completion: completion)
    }
}
