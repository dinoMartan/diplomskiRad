//
//  UserRepositoryMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

import UIKit
@testable import Connect

class UserRepositoryMock: UserRepositoryProtocol {
    private let dataMock = DataMock()

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

        guard let myError = myError else {
            completion(.success(dataMock.getUser()))
            return
        }
        completion(.failure(myError))
    }
    
    func setUser(user: User, userImage: UIImage?, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        setUserCalled = true
        setUserCounter += 1
        self.user = user
        self.userImage = userImage

        guard let myError = myError else {
            completion(.success(()))
            return
        }
        completion(.failure(myError))
    }
}
