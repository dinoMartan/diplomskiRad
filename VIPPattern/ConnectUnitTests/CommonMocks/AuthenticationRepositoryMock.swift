//
//  AuthenticationRepositoryMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

import FirebaseAuth
@testable import Connect

class AuthenticationRepositoryMock: AuthenticationRepositoryProtocol {
    private let dataMock = DataMock()

    var myError: MyError?

    var signInUserCalled = false
    var signInUserCounter = 0

    var registerUserCalled = false
    var registerUserCounter = 0

    var sendResetPasswordEmailCalled = false
    var sendResetPasswordEmailCounter = 0

    var email: String?
    var password: String?
}

extension AuthenticationRepositoryMock {
    func signInUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        signInUserCalled = true
        signInUserCounter += 1
        self.email = email
        self.password = password

        guard let myError = myError else {
            completion(.success(dataMock.getAuthenticationResponse()))
            return
        }
        completion(.failure(myError))
    }
    
    func registerUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) {
        registerUserCalled = true
        registerUserCounter += 1
        self.email = email
        self.password = password

        guard let myError = myError else {
            completion(.success(dataMock.getAuthenticationResponse()))
            return
        }
        completion(.failure(myError))
    }
    
    func sendResetPasswordEmail(email: String, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        sendResetPasswordEmailCalled = true
        sendResetPasswordEmailCounter += 1
        self.email = email

        guard let myError = myError else {
            completion(.success(()))
            return
        }
        completion(.failure(myError))
    }
}
