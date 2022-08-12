 //
//  ConversationDetailsViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.08.2022..
//

@testable import Connect

class ConversationDetailsViewControllerMock {
    var didSucceedGetConversationCalled = false
    var didSucceedGetConversationCounter = 0
    var didSucceedGetConversationViewModel: ConversationDetails.GetConversationAction.ViewModel.Success?

    var didFailGetConversationCalled = false
    var didFailGetConversationCounter = 0
    var didFailGetConversationViewModel: ConversationDetails.GetConversationAction.ViewModel.Failure?

    var didSucceedSendMessageCalled = false
    var didSucceedSendMessageCounter = 0
    var didSucceedSendMessageViewModel: ConversationDetails.SendMessageAction.ViewModel.Success?

    var didFailSendMessageCalled = false
    var didFailSendMessageCounter = 0
    var didFailSendMessageViewModel: ConversationDetails.SendMessageAction.ViewModel.Failure?
}

extension ConversationDetailsViewControllerMock: ConversationDetailsPresenterOutput {
    func presenter(didSucceedGetConversation viewModel: ConversationDetails.GetConversationAction.ViewModel.Success) {
        didSucceedGetConversationCalled = true
        didSucceedGetConversationCounter += 1
        didSucceedGetConversationViewModel = viewModel
    }
    
    func presenter(didFailGetConversation viewModel: ConversationDetails.GetConversationAction.ViewModel.Failure) {
        didFailGetConversationCalled = true
        didFailGetConversationCounter += 1
        didFailGetConversationViewModel = viewModel
    }
    
    func interactor(didSucceedSendMessage viewModel: ConversationDetails.SendMessageAction.ViewModel.Success) {
        didSucceedSendMessageCalled = true
        didSucceedSendMessageCounter += 1
        didSucceedSendMessageViewModel = viewModel
    }
    
    func interactor(didFailSendMessage viewModel: ConversationDetails.SendMessageAction.ViewModel.Failure) {
        didFailSendMessageCalled = true
        didFailSendMessageCounter += 1
        didFailSendMessageViewModel = viewModel
    }
}
