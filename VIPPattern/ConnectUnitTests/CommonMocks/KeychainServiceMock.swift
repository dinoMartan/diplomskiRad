//
//  KeychainServiceMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

@testable import Connect

class KeychainServiceMock: KeychainServiceProtocol {
    var userLoggedIn: Bool?
    var userId: String?
}

extension KeychainServiceMock {
    func getUserLoggedIn() -> Bool {
        userLoggedIn ?? false
    }

    func setUserLoggedIn(_ userLoggedIn: Bool) {
        self.userLoggedIn = userLoggedIn
    }
}

extension KeychainServiceMock {
    func getUserId() -> String? {
        userId
    }

    func setUserId(_ userId: String?) {
        self.userId = userId
    }
}
