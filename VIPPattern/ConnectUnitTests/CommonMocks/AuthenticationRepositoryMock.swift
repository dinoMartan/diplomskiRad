//
//  AuthenticationRepositoryMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

import FirebaseAuth
@testable import Connect

class AuthenticationRepositoryMock: AuthenticationRepositoryProtocol {
    var expectedResponse: Any?
    var myError: MyError?

    var signInUserCalled = false
    var signInUserCounter = 0

    var registerUserCalled = false
    var registerUserCounter = 0

    var sendResetPasswordEmailCalled = false
    var sendResetPasswordEmailCounter = 0

    var email: String?
    var password: String?

    var signOutCalled = false
    var signOutCounter = 0
}

extension AuthenticationRepositoryMock {
    func signInUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        signInUserCalled = true
        signInUserCounter += 1
        self.email = email
        self.password = password

        handleCompletion(completion)
    }
    
    func registerUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        registerUserCalled = true
        registerUserCounter += 1
        self.email = email
        self.password = password

        handleCompletion(completion)
    }
    
    func sendResetPasswordEmail(email: String, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        sendResetPasswordEmailCalled = true
        sendResetPasswordEmailCounter += 1
        self.email = email

        handleVoidCompletion(completion)
    }

    func signOut(completion: @escaping ((Result<Void, MyError>) -> Void)) {
        signOutCalled = true
        signOutCounter += 1

        handleVoidCompletion(completion)
    }

    private func handleCompletion<T: Codable>(_ completion: @escaping ((Result<T, MyError>) -> Void)) {
        guard let myError = myError else {
            guard let expectedResponse = expectedResponse else {
                return
            }
            completion(.success(expectedResponse as! T))
            return
        }
        completion(.failure(myError))
    }

    private func handleVoidCompletion(_ completion: @escaping ((Result<Void, MyError>) -> Void)) {
        guard let myError = myError else {
            guard expectedResponse != nil else {
                return
            }
            completion(.success(expectedResponse as! Void))
            return
        }
        completion(.failure(myError))
    }
}
