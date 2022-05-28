//
//  Dependencies.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation
import KeychainSwift

protocol DependenciesProtocol {
    var keychainService: KeychainServiceProtocol { get }
    var firestoreService: FirestoreServiceProtocol { get }
}

class Dependencies: DependenciesProtocol {
    var keychainService: KeychainServiceProtocol
    var firestoreService: FirestoreServiceProtocol

    init() {
        keychainService = KeychainService()
        firestoreService = FirestoreService()
    }
}
