//
//  Dependencies.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation
import KeychainSwift

protocol DependenciesProtocol {
    var keychainService: KeychainServiceProtocol { get }
}

class Dependencies: DependenciesProtocol {
    var keychainService: KeychainServiceProtocol

    init() {
        keychainService = KeychainService()
    }
}
