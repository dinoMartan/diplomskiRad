//
//  DataMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

@testable import Connect
import Foundation

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

    // Project
    var projectId: String? = "project id"
    var projectTitle: String? = "project title"
    var projectCreatedAt: Date? = Date(timeIntervalSince1970: 12345)
    var projectDescription: String? = "project description"
    var projectHaveTags: [String]? = ["have1", "have2"]
    var projectNeedTags: [String]? = ["need1", "need2"]
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

extension DataMock {
    func getProject() -> Project {
        Project(id: projectId,
                title: projectTitle,
                createdAt: projectCreatedAt,
                description: projectDescription,
                haveTags: projectHaveTags,
                needTags: projectNeedTags,
                owner: getUser().getUserNested())
    }
}
