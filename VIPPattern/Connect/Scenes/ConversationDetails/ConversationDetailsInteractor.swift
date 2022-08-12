 //
//  ConversationDetailsInteractor.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

protocol ConversationDetailsInteractorProtocol {
    func getConversation(request: ConversationDetails.GetConversationAction.Request)
    func sendMessage(request: ConversationDetails.SendMessageAction.Request)
}

class ConversationDetailsInteractor: ConversationDetailsInteractorProtocol {
    var presenter: ConversationDetailsPresenterProtocol?

    private let conversationsRepository: ConversationsRepositoryProtocol
    private let keychainService: KeychainServiceProtocol
    private let conversationId: String
    private var conversation: Conversation?

    init(conversationsRepository: ConversationsRepositoryProtocol, keychainService: KeychainServiceProtocol, conversationId: String) {
        self.conversationsRepository = conversationsRepository
        self.keychainService = keychainService
        self.conversationId = conversationId
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ConversationDetailsInteractor {
    func getConversation(request: ConversationDetails.GetConversationAction.Request) {
        guard let currentUserId = keychainService.getUserId() else { return }
        conversationsRepository.observeConversation(conversationId) { [weak self] result in
            switch result {
            case .success(let conversation):
                self?.conversation = conversation
                let response = ConversationDetails.GetConversationAction.Response.Success(currentUserId: currentUserId,
                                                                                          conversation: conversation)
                self?.presenter?.interactor(didSucceedGetConversation: response)
            case .failure(let myError):
                let response = ConversationDetails.GetConversationAction.Response.Failure(myError: myError)
                self?.presenter?.interactor(didFailGetConversation: response)
            }
        }
    }

    func sendMessage(request: ConversationDetails.SendMessageAction.Request) {
        guard var conversation = conversation,
              let currentUserId = keychainService.getUserId()
        else { return }
        let message = Message(createdAt: Date(),
                              type: .text,
                              senderId: currentUserId,
                              value: request.message)
        conversation.messages?.append(message)
        conversationsRepository.setConversation(conversation) { [weak self] result in
            switch result {
            case .success(_):
                let response = ConversationDetails.SendMessageAction.Response.Success()
                self?.presenter?.interactor(didSucceedSendMessage: response)
            case .failure(let myError):
                let response = ConversationDetails.SendMessageAction.Response.Failure(myError: myError)
                self?.presenter?.interactor(didFailSendMessage: response)
            }
        }
    }
}
