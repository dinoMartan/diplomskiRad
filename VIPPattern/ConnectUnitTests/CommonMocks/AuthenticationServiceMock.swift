//
//  AuthenticationServiceMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.08.2022..
//

import FirebaseAuth
import Foundation
@testable import Connect

class AuthenticationServiceMock: AuthenticationServiceProtocol {
    var myError: MyError?
    var expectedResponse: Any?

    var registerUserCalled = false
    var registerUserCounter = 0
    var registerUserEmail: String?
    var registerUserPassword: String?

    var signInUserCalled = false
    var signInUserCounter = 0
    var signInUserEmail: String?
    var signInUserPassword: String?

    var sendResetPasswordEmailCalled = false
    var sendResetPasswordEmailCounter = 0
    var sendResetPasswordEmailEmail: String?

    var signOutCalled = false
    var signOutCounter = 0

    func registerUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        registerUserCalled = true
        registerUserCounter += 1
        registerUserEmail = email
        registerUserPassword = password

        handleCompletion(completion)
    }

    func signInUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        signInUserCalled = true
        signInUserCounter += 1
        signInUserEmail = email
        signInUserPassword = password

        handleCompletion(completion)
    }

    func sendResetPasswordEmail(email: String, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        sendResetPasswordEmailCalled = true
        sendResetPasswordEmailCounter += 1
        sendResetPasswordEmailEmail = email

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
