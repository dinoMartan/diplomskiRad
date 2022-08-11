//
//  ConversationsRepositoryMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 06.08.2022..
//

@testable import Connect

class ConversationsRepositoryMock: ConversationsRepositoryProtocol {
    var myError: MyError?
    var expectedResponse: Any?

    var setConversationCalled = false
    var setConversationCounter = 0
    var setConversationConversation: Conversation?

    var observeConversationsForUserCalled = false
    var observeConversationsForUserCounter = 0
    var observeConversationsForUserUserId: String?

    func setConversation(_ conversation: Conversation, completion: @escaping ((Result<String, MyError>) -> Void)) {
        setConversationCalled = true
        setConversationCounter += 1
        setConversationConversation = conversation

        handleCompletion(completion)
    }
    
    func observeConversationsForUser(_ userId: String, completion: @escaping ((Result<[Conversation], MyError>) -> Void)) {
        observeConversationsForUserCalled = true
        observeConversationsForUserCounter += 1
        observeConversationsForUserUserId = userId

        handleCompletion(completion)
    }

    private func handleCompletion<T: Codable>(_ completion: @escaping ((Result<T, MyError>) -> Void)) {
        guard let myError = myError else {
            guard let expectedResponse = expectedResponse else {
                return
            }
            completion(.success(expectedResponse as! T))
            return
        }
        completion(.failure(myError))
    }
}
