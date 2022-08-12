 //
//  ConversationDetailsInteractorTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.08.2022..
//

import Foundation
@testable import Connect
import XCTest

class ConversationDetailsInteractorTests: XCTestCase {
    private var sut: ConversationDetailsInteractor!
    private var conversationDetailsPresenterMock: ConversationDetailsPresenterMock!
    private var conversationDetailsDataModelMock: ConversationDetailsDataModelMock!
    private var conversationsRepositoryMock: ConversationsRepositoryMock!
    private var keychainServiceMock: KeychainServiceMock!
    private var dataMock: DataMock!
    private let conversationId = "conv id"

    override func setUpWithError() throws {
        conversationDetailsDataModelMock = ConversationDetailsDataModelMock()
        conversationDetailsPresenterMock = ConversationDetailsPresenterMock()
        conversationsRepositoryMock = ConversationsRepositoryMock()
        keychainServiceMock = KeychainServiceMock()
        dataMock = DataMock()
        sut = ConversationDetailsInteractor(conversationsRepository: conversationsRepositoryMock,
                                            keychainService: keychainServiceMock,
                                            conversationId: conversationId)
        sut.presenter = conversationDetailsPresenterMock
    }

    override func tearDownWithError() throws {
        conversationDetailsDataModelMock = nil
        conversationDetailsPresenterMock = nil
        conversationsRepositoryMock = nil
        keychainServiceMock = nil
        dataMock = nil
        sut = nil
    }
}

// MARK: getConversation(request: ConversationDetails.GetConversationAction.Request) tests
extension ConversationDetailsInteractorTests {
    func testGetConversation_WhenCalledWithRequestAndUserIdIsNotSet_ShouldNotCallConversationRepositoryObserveConversation() {
        // Given
        let request = conversationDetailsDataModelMock.getConversationAction.request

        // When
        sut.getConversation(request: request)

        // Then
        XCTAssertFalse(conversationsRepositoryMock.observeConversationCalled)
    }

    func testGetConversation_WhenCalledWithRequestAndUserIdIsSet_ShouldCallConversationRepositoryObserveConversationWithConversationId() {
        // Given
        let request = conversationDetailsDataModelMock.getConversationAction.request
        let userId = "user id"
        keychainServiceMock.setUserId(userId)

        // When
        sut.getConversation(request: request)

        // Then
        XCTAssertTrue(conversationsRepositoryMock.observeConversationCalled)
        XCTAssertEqual(conversationsRepositoryMock.observeConversationCounter, 1)
        XCTAssertEqual(conversationsRepositoryMock.observeConversationConversationId, conversationId)
    }

    func testGetConversation_WhenCalledWithRequestAndUserIdIsSetOnSuccess_ShouldCallPresenterWithResponse() {
        // Given
        let request = conversationDetailsDataModelMock.getConversationAction.request
        let expectedResponse = conversationDetailsDataModelMock.getConversationAction.responseSuccess
        let userId = dataMock.userId ?? ""
        keychainServiceMock.setUserId(userId)
        conversationsRepositoryMock.expectedResponse = dataMock.getConversation()

        // When
        sut.getConversation(request: request)

        // Then
        XCTAssertTrue(conversationDetailsPresenterMock.didSucceedGetConversationCalled)
        XCTAssertEqual(conversationDetailsPresenterMock.didSucceedGetConversationCounter, 1)
        XCTAssertEqual(conversationDetailsPresenterMock.didSucceedGetConversationResponse, expectedResponse)
    }

    func testGetConversation_WhenCalledWithRequestAndUserIdIsSetOnFailure_ShouldCallPresenterWithResponse() {
        // Given
        let request = conversationDetailsDataModelMock.getConversationAction.request
        let expectedResponse = conversationDetailsDataModelMock.getConversationAction.responseFailure
        let userId = dataMock.userId ?? ""
        keychainServiceMock.setUserId(userId)
        conversationsRepositoryMock.myError = ConversationDetailsDataModelMock.myError

        // When
        sut.getConversation(request: request)

        // Then
        XCTAssertTrue(conversationDetailsPresenterMock.didFailGetConversationCalled)
        XCTAssertEqual(conversationDetailsPresenterMock.didFailGetConversationCounter, 1)
        XCTAssertEqual(conversationDetailsPresenterMock.didFailGetConversationResponse, expectedResponse)
    }
}

// MARK: sendMessage(request: ConversationDetails.SendMessageAction.Request) tests
extension ConversationDetailsInteractorTests {
    func testSendMessage_WhenCalledWithRequestAndUserIdIsNotSet_ShouldNotCallConversationRepositorySetConversation() {
        // Given
        let request = conversationDetailsDataModelMock.sendMessageAction.request

        // When
        sut.sendMessage(request: request)

        // Then
        XCTAssertFalse(conversationsRepositoryMock.setConversationCalled)
    }

    func testSendMessage_WhenCalledWithRequestAndUserIdIsSetAndConversationIsSet_ShouldCallConversationRepositorySetConversation() {
        // Given
        let request = conversationDetailsDataModelMock.sendMessageAction.request
        let userId = dataMock.messageSenderId ?? ""
        keychainServiceMock.setUserId(userId)
        let conversation = dataMock.getConversation()
        conversationsRepositoryMock.expectedResponse = conversation
        let getConversationRequest = conversationDetailsDataModelMock.getConversationAction.request
        sut.getConversation(request: getConversationRequest)
        conversationsRepositoryMock.expectedResponse = nil

        // When
        sut.sendMessage(request: request)

        // Then
        XCTAssertTrue(conversationsRepositoryMock.setConversationCalled)
        XCTAssertEqual(conversationsRepositoryMock.setConversationCounter, 1)
    }

    func testSendMessage_WhenCalledWithRequestAndUserIdIsSetOnSuccess_ShouldCallPresenterWithResponse() {
        // Given
        let request = conversationDetailsDataModelMock.sendMessageAction.request
        let expectedResponse = conversationDetailsDataModelMock.sendMessageAction.responseSuccess
        let userId = dataMock.messageSenderId ?? ""
        keychainServiceMock.setUserId(userId)
        let conversation = dataMock.getConversation()
        conversationsRepositoryMock.expectedResponse = conversation
        let getConversationRequest = conversationDetailsDataModelMock.getConversationAction.request
        sut.getConversation(request: getConversationRequest)
        conversationsRepositoryMock.expectedResponse = ""

        // When
        sut.sendMessage(request: request)

        // Then
        XCTAssertTrue(conversationDetailsPresenterMock.didSucceedSendMessageCalled)
        XCTAssertEqual(conversationDetailsPresenterMock.didSucceedSendMessageCounter, 1)
        XCTAssertEqual(conversationDetailsPresenterMock.didSucceedSendMessageResponse, expectedResponse)
    }

    func testSendMessage_WhenCalledWithRequestAndUserIdIsSetOnFailure_ShouldCallPresenterWithResponse() {
        // Given
        let request = conversationDetailsDataModelMock.sendMessageAction.request
        let expectedResponse = conversationDetailsDataModelMock.sendMessageAction.responseFailure
        let userId = dataMock.messageSenderId ?? ""
        keychainServiceMock.setUserId(userId)
        let conversation = dataMock.getConversation()
        conversationsRepositoryMock.expectedResponse = conversation
        let getConversationRequest = conversationDetailsDataModelMock.getConversationAction.request
        sut.getConversation(request: getConversationRequest)
        conversationsRepositoryMock.myError = ConversationDetailsDataModelMock.myError

        // When
        sut.sendMessage(request: request)

        // Then
        XCTAssertTrue(conversationDetailsPresenterMock.didFailSendMessageCalled)
        XCTAssertEqual(conversationDetailsPresenterMock.didFailSendMessageCounter, 1)
        XCTAssertEqual(conversationDetailsPresenterMock.didFailSendMessageResponse, expectedResponse)
    }
}
