//
//  ConversationsRepositoryMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 06.08.2022..
//

@testable import Connect

class ConversationsRepositoryMock: ConversationsRepositoryProtocol {
    func setConversation(_ conversation: Conversation, completion: @escaping ((Result<String, MyError>) -> Void)) {
        //
    }
    
    func observeConversationsForUser(_ userId: String, completion: @escaping ((Result<[Conversation], MyError>) -> Void)) {
        //
    }
}
