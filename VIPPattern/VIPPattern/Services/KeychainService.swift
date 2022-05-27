//
//  KeychainService.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation
import KeychainSwift

protocol KeychainServiceProtocol {
    func getUserLoggedIn() -> Bool
    func setUserLoggedIn(_ userLoggedIn: Bool)

    func getUserId() -> String?
    func setUserId(_ userId: String)
}

class KeychainService: KeychainServiceProtocol {
    private let keychainSwift: KeychainSwift

    private enum Key: String {
        case userLoggedIn
        case userId
    }

    init() {
        keychainSwift = KeychainSwift()
    }
}

extension KeychainService {
    func getUserLoggedIn() -> Bool {
        keychainSwift.getBool(Key.userLoggedIn.rawValue) ?? false
    }

    func setUserLoggedIn(_ userLoggedIn: Bool) {
        keychainSwift.set(userLoggedIn, forKey: Key.userLoggedIn.rawValue)
    }
}

extension KeychainService {
    func getUserId() -> String? {
        keychainSwift.get(Key.userId.rawValue)
    }

    func setUserId(_ userId: String) {
        keychainSwift.set(userId, forKey: Key.userId.rawValue)
    }
}
