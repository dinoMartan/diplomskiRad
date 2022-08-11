 //
//  ConversationDetailsPresenter.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

protocol ConversationDetailsPresenterProtocol: AnyObject {
    func interactor(didSucceedGetConversation response: ConversationDetails.GetConversationAction.Response.Success)
    func interactor(didFailGetConversation response: ConversationDetails.GetConversationAction.Response.Failure)
}

class ConversationDetailsPresenter: ConversationDetailsPresenterProtocol {
    weak var viewController: ConversationDetailsPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedGetConversation response: ConversationDetails.GetConversationAction.Response.Success) {
        let viewModel = ConversationDetails.GetConversationAction.ViewModel.Success(pojectTitle: response.conversation.project?.title ?? "",
                                                                                    messages: mapConversationToCDMessages(response.conversation,
                                                                                                                          currentUserId: response.currentUserId))
        viewController?.presenter(didSucceedGetConversation: viewModel)
    }

    private func mapConversationToCDMessages(_ conversation: Conversation?, currentUserId: String) -> [ConversationDetails.CDMessage] {
        let currentUser = conversation?.conversationOwner?.id == currentUserId ? conversation?.conversationOwner : conversation?.project?.owner
        let otherUser = conversation?.conversationOwner?.id != currentUserId ? conversation?.project?.owner : conversation?.conversationOwner
        return conversation?.messages?.map {
            ConversationDetails.CDMessage(value: $0.value ?? "",
                                          isCurrentUsersMessage: $0.senderId == currentUserId,
                                          image: ($0.senderId == currentUserId ? currentUser?.profileImage : otherUser?.profileImage) ?? "")
        } ?? []
    }

    func interactor(didFailGetConversation response: ConversationDetails.GetConversationAction.Response.Failure) {
        let viewModel = ConversationDetails.GetConversationAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailGetConversation: viewModel)
    }
}
