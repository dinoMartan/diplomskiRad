//
//  ConversationsRepository.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

protocol ConversationsRepositoryProtocol {
    func setConversation(_ conversation: Conversation, completion: @escaping ((Result<String, MyError>) -> Void))
    func observeConversationsForUser(_ userId: String, completion: @escaping ((Result<[Conversation], MyError>) -> Void))
    func observeConversation(_ conversationId: String, completion: @escaping ((Result<Conversation, MyError>) -> Void))
}

class ConversationsRepository: ConversationsRepositoryProtocol {
    private let firestoreService: FirestoreServiceProtocol

    init(firestoreService: FirestoreServiceProtocol) {
        self.firestoreService = firestoreService
    }

    deinit {
        print("deinit \(self)")
    }

    func setConversation(_ conversation: Conversation, completion: @escaping ((Result<String, MyError>) -> Void)) {
        var conversationId: String
        if let id = conversation.id {
            conversationId = id
        } else {
            conversationId = UUID().uuidString
        }
        firestoreService.setDocument(documentPath: "conversations/" + conversationId, document: conversation) { result in
            switch result {
            case .success(_):
                completion(.success(conversationId))
            case .failure(let myError):
                completion(.failure(myError))
            }
        }
    }

    func observeConversationsForUser(_ userId: String, completion: @escaping ((Result<[Conversation], MyError>) -> Void)) {
        firestoreService.getCollectionWhereField("userIds", arrayContains: userId, on: "conversations", isRealTime: true, completion: completion)
    }

    func observeConversation(_ conversationId: String, completion: @escaping ((Result<Conversation, MyError>) -> Void)) {
        firestoreService.observeDocument(documentPath: "conversations/" + conversationId, completion: completion)
    }
}
