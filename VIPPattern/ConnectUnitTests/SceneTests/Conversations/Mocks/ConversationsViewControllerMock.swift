 //
//  ConversationsViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 11.08.2022..
//

@testable import Connect

class ConversationsViewControllerMock {
    var didSucceedGetUsersConversationsCalled = false
    var didSucceedGetUsersConversationsCounter = 0
    var didSucceedGetUsersConversationsViewModel: Conversations.GetUsersConversationsAction.ViewModel.Success?

    var didFailGetUsersConversationsCalled = false
    var didFailGetUsersConversationsCounter = 0
    var didFailGetUsersConversationsViewModel: Conversations.GetUsersConversationsAction.ViewModel.Failure?
}

extension ConversationsViewControllerMock: ConversationsPresenterOutput {
    func presenter(didSucceedGetUsersConversations viewModel: Conversations.GetUsersConversationsAction.ViewModel.Success) {
        didSucceedGetUsersConversationsCalled = true
        didSucceedGetUsersConversationsCounter += 1
        didSucceedGetUsersConversationsViewModel = viewModel
    }
    
    func presenter(didFailGetUsersConversations viewModel: Conversations.GetUsersConversationsAction.ViewModel.Failure) {
        didFailGetUsersConversationsCalled = true
        didFailGetUsersConversationsCounter += 1
        didFailGetUsersConversationsViewModel = viewModel
    }
}
