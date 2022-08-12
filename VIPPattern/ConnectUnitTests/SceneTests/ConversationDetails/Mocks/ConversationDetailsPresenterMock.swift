 //
//  ConversationDetailsPresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.08.2022..
//

@testable import Connect

class ConversationDetailsPresenterMock {
    var didSucceedGetConversationCalled = false
    var didSucceedGetConversationCounter = 0
    var didSucceedGetConversationResponse: ConversationDetails.GetConversationAction.Response.Success?

    var didFailGetConversationCalled = false
    var didFailGetConversationCounter = 0
    var didFailGetConversationResponse: ConversationDetails.GetConversationAction.Response.Failure?

    var didSucceedSendMessageCalled = false
    var didSucceedSendMessageCounter = 0
    var didSucceedSendMessageResponse: ConversationDetails.SendMessageAction.Response.Success?

    var didFailSendMessageCalled = false
    var didFailSendMessageCounter = 0
    var didFailSendMessageResponse: ConversationDetails.SendMessageAction.Response.Failure?
}

extension ConversationDetailsPresenterMock: ConversationDetailsPresenterProtocol {
    func interactor(didSucceedGetConversation response: ConversationDetails.GetConversationAction.Response.Success) {
        didSucceedGetConversationCalled = true
        didSucceedGetConversationCounter += 1
        didSucceedGetConversationResponse = response
    }
    
    func interactor(didFailGetConversation response: ConversationDetails.GetConversationAction.Response.Failure) {
        didFailGetConversationCalled = true
        didFailGetConversationCounter += 1
        didFailGetConversationResponse = response
    }
    
    func interactor(didSucceedSendMessage response: ConversationDetails.SendMessageAction.Response.Success) {
        didSucceedSendMessageCalled = true
        didSucceedSendMessageCounter += 1
        didSucceedSendMessageResponse = response
    }
    
    func interactor(didFailSendMessage response: ConversationDetails.SendMessageAction.Response.Failure) {
        didFailSendMessageCalled = true
        didFailSendMessageCounter += 1
        didFailSendMessageResponse = response
    }
}
