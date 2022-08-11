//
//  DataMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

@testable import Connect
import Foundation

struct DataMock {
    static let date = Date()

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

    // Conversation
    var conversationId: String? = "conversation id"
    var conversationUserIds: [String]? = ["id1", "id2"]
    var conversationCreatedAt: Date? = DataMock.date

    // Message
    var messageCreatedAt: Date? = DataMock.date
    var messageType: MessageType? = .text
    var messageSenderId: String? = "id1"
    var messageValue: String? = "message value"
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

extension DataMock {
    func getMessage() -> Message {
        Message(createdAt: messageCreatedAt,
                type: messageType,
                senderId: messageSenderId,
                value: messageValue)
    }
}

extension DataMock {
    func getConversation() -> Conversation {
        Conversation(id: conversationId,
                     project: getProject().getProjectNested(),
                     users: [getUser().getUserNested()],
                     userIds: conversationUserIds,
                     createdAt: conversationCreatedAt,
                     messages: [getMessage()])
    }
}
