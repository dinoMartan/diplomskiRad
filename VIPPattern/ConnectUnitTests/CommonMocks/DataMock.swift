//
//  DataMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

@testable import Connect

class DataMock {
    // User
    var userId: String? = "id"
    var userUsername: String? = "username"
    var userFirstName: String? = "first name"
    var userLastName: String? = "last name"
    var userEmail: String? = "email@email.com"
    var userProfileImage: String? = "www.google.com"

    // Authentication
    var authenticationUserId: String? = "user id"
}

extension DataMock {
    func getUser() -> User {
        User(id: userId,
             username: userUsername,
             firstName: userFirstName,
             lastName: userLastName,
             email: userEmail,
             profileImage: userProfileImage)
    }

    func getAuthenticationResponse() -> AuthenticationResponse {
        AuthenticationResponse(userId: authenticationUserId)
    }
}
