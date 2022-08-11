 //
//  ConversationDetailsInteractor.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

protocol ConversationDetailsInteractorProtocol {
    func getConversation(request: ConversationDetails.GetConversationAction.Request)
}

class ConversationDetailsInteractor: ConversationDetailsInteractorProtocol {
    var presenter: ConversationDetailsPresenterProtocol?

    private let conversationsRepository: ConversationsRepositoryProtocol
    private let conversationId: String

    init(conversationsRepository: ConversationsRepositoryProtocol, conversationId: String) {
        self.conversationsRepository = conversationsRepository
        self.conversationId = conversationId
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ConversationDetailsInteractor {
    func getConversation(request: ConversationDetails.GetConversationAction.Request) {
        //
    }
}
