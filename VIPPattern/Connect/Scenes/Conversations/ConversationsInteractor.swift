 //
//  ConversationsInteractor.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol ConversationsInteractorProtocol {
    func getUsersConversations(request: Conversations.GetUsersConversationsAction.Request)
}

class ConversationsInteractor: ConversationsInteractorProtocol {
    var presenter: ConversationsPresenterProtocol?

    private let keychainServices: KeychainServiceProtocol
    private let conversationsRepository: ConversationsRepositoryProtocol

    init(keychainServices: KeychainServiceProtocol, conversationsRepository: ConversationsRepositoryProtocol) {
        self.keychainServices = keychainServices
        self.conversationsRepository = conversationsRepository
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ConversationsInteractor {
    func getUsersConversations(request: Conversations.GetUsersConversationsAction.Request) {
        guard let userId = keychainServices.getUserId() else { return }
        conversationsRepository.observeConversationsForUser(userId) { [weak self] result in
            switch result {
            case .success(let conversations):
                let response = Conversations.GetUsersConversationsAction.Response.Success(currentUserId: userId,
                                                                                          conversations: conversations)
                self?.presenter?.interactor(didSucceedGetUsersConversations: response)
            case .failure(let myError):
                let response = Conversations.GetUsersConversationsAction.Response.Failure(myError: myError)
                self?.presenter?.interactor(didFailGetUsersConversations: response)
            }
        }
    }
}
