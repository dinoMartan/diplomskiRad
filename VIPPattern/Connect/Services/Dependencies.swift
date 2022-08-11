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
    var authenticationService: AuthenticationServiceProtocol { get }
}

class Dependencies: DependenciesProtocol {
    var keychainService: KeychainServiceProtocol
    var firestoreService: FirestoreServiceProtocol
    var authenticationService: AuthenticationServiceProtocol

    init() {
        keychainService = KeychainService()
        firestoreService = FirestoreService()
        authenticationService = AuthenticationService()
    }
}
