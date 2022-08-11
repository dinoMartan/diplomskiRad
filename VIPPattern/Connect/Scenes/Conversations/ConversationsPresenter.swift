 //
//  ConversationsPresenter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol ConversationsPresenterProtocol: AnyObject {
    func interactor(didSucceedGetUsersConversations response: Conversations.GetUsersConversationsAction.Response.Success)
    func interactor(didFailGetUsersConversations response: Conversations.GetUsersConversationsAction.Response.Failure)
}

class ConversationsPresenter: ConversationsPresenterProtocol {
    weak var viewController: ConversationsPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedGetUsersConversations response: Conversations.GetUsersConversationsAction.Response.Success) {
        let conversations = response.conversations.map { conversation -> Conversations.CConversation in
            let user = getUserFromConversation(conversation, currentUserId: response.currentUserId)
            let lastMessage = conversation.messages?.last?.value
            return Conversations.CConversation(id: conversation.id,
                                               image: user?.profileImage,
                                               name: user?.firstName,
                                               lastMessage: lastMessage)
        }
        let viewModel = Conversations.GetUsersConversationsAction.ViewModel.Success(conversations: conversations)
        viewController?.presenter(didSucceedGetUsersConversations: viewModel)
    }

    private func getUserFromConversation(_ conversation: Conversation, currentUserId: String) -> UserNested? {
        if conversation.conversationOwner?.id == currentUserId {
            return conversation.project?.owner
        } else {
            return conversation.conversationOwner
        }
    }

    func interactor(didFailGetUsersConversations response: Conversations.GetUsersConversationsAction.Response.Failure) {
        let viewModel = Conversations.GetUsersConversationsAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailGetUsersConversations: viewModel)
    }
}
