//
//  UserRepositoryMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

import UIKit
@testable import Connect

class UserRepositoryMock: UserRepositoryProtocol {
    var expectedResponse: Any?
    var myError: MyError?

    var getUserCalled = false
    var getUserCounter = 0
    var userId: String?

    var setUserCalled = false
    var setUserCounter = 0
    var user: User?
    var userImage: UIImage?
}

extension UserRepositoryMock {
    func getUser(userId: String, completion: @escaping ((Result<User, MyError>) -> Void)) {
        getUserCalled = true
        getUserCounter += 1
        self.userId = userId

        handleCompletion(completion)
    }
    
    func setUser(user: User, userImage: UIImage?, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        setUserCalled = true
        setUserCounter += 1
        self.user = user
        self.userImage = userImage

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
