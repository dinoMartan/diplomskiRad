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
}

class KeychainService: KeychainServiceProtocol {
    private let keychainSwift: KeychainSwift

    private enum Key: String {
        case userLoggedIn
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
