 //
//  ConversationsPresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 11.08.2022..
//

@testable import Connect

class ConversationsPresenterMock {
    var didSucceedGetUsersConversationsCalled = false
    var didSucceedGetUsersConversationsCounter = 0
    var didSucceedGetUsersConversationsResponse: Conversations.GetUsersConversationsAction.Response.Success?

    var didFailGetUsersConversationsCalled = false
    var didFailGetUsersConversationsCounter = 0
    var didFailGetUsersConversationsResponse: Conversations.GetUsersConversationsAction.Response.Failure?
}

extension ConversationsPresenterMock: ConversationsPresenterProtocol {
    func interactor(didSucceedGetUsersConversations response: Conversations.GetUsersConversationsAction.Response.Success) {
        didSucceedGetUsersConversationsCalled = true
        didSucceedGetUsersConversationsCounter += 1
        didSucceedGetUsersConversationsResponse = response
    }

    func interactor(didFailGetUsersConversations response: Conversations.GetUsersConversationsAction.Response.Failure) {
        didFailGetUsersConversationsCalled = true
        didFailGetUsersConversationsCounter += 1
        didFailGetUsersConversationsResponse = response
    }
}
