 //
//  ConversationsInteractorTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 11.08.2022..
//

@testable import Connect
import XCTest

class ConversationsInteractorTests: XCTestCase {
    private var sut: ConversationsInteractor!
    private var conversationsPresenterMock: ConversationsPresenterMock!
    private var conversationsDataModelMock: ConversationsDataModelMock!
    private var keychainServiceMock: KeychainServiceMock!
    private var conversationsRepositoryMock: ConversationsRepositoryMock!
    private var dataMock: DataMock!

    override func setUpWithError() throws {
        conversationsDataModelMock = ConversationsDataModelMock()
        conversationsPresenterMock = ConversationsPresenterMock()
        keychainServiceMock = KeychainServiceMock()
        conversationsRepositoryMock = ConversationsRepositoryMock()
        dataMock = DataMock()
        sut = ConversationsInteractor(keychainServices: keychainServiceMock,
                                      conversationsRepository: conversationsRepositoryMock)
        sut.presenter = conversationsPresenterMock
    }

    override func tearDownWithError() throws {
        conversationsDataModelMock = nil
        conversationsPresenterMock = nil
        keychainServiceMock = nil
        conversationsRepositoryMock = nil
        dataMock = nil
        sut = nil
    }
}

// MARK: getUsersConversations(request: Conversations.GetUsersConversationsAction.Request) tests
extension ConversationsInteractorTests {
    func testGetUsersConversations_WhenCalledWithRequestAndUserIdIsNotSet_ShouldNotCallConversationsRpositoryObserveConversationsForUser() {
        // Given
        let request = conversationsDataModelMock.getUsersConversationsAction.request

        // When
        sut.getUsersConversations(request: request)

        // Then
        XCTAssertFalse(conversationsRepositoryMock.observeConversationsForUserCalled)
    }

    func testGetUsersConversations_WhenCalledWithRequestAndUserIdIsSet_ShouldCallConversationsRpositoryObserveConversationsForUserWithUserId() {
        // Given
        let request = conversationsDataModelMock.getUsersConversationsAction.request
        let userId = "user id"
        keychainServiceMock.setUserId(userId)

        // When
        sut.getUsersConversations(request: request)

        // Then
        XCTAssertTrue(conversationsRepositoryMock.observeConversationsForUserCalled)
        XCTAssertEqual(conversationsRepositoryMock.observeConversationsForUserCounter, 1)
        XCTAssertEqual(conversationsRepositoryMock.observeConversationsForUserUserId, userId)
    }

    func testGetUsersConversations_WhenCalledWithRequestAndUserIdIsSetOnSuccess_ShouldCallPresenterWithResponse() {
        // Given
        let request = conversationsDataModelMock.getUsersConversationsAction.request
        let userId = dataMock.userId ?? ""
        keychainServiceMock.setUserId(userId)
        let expectedResponse = conversationsDataModelMock.getUsersConversationsAction.responseSuccess
        conversationsRepositoryMock.expectedResponse = [dataMock.getConversation()]

        // When
        sut.getUsersConversations(request: request)

        // Then
        XCTAssertTrue(conversationsPresenterMock.didSucceedGetUsersConversationsCalled)
        XCTAssertEqual(conversationsPresenterMock.didSucceedGetUsersConversationsCounter, 1)
        XCTAssertEqual(conversationsPresenterMock.didSucceedGetUsersConversationsResponse, expectedResponse)
    }

    func testGetUsersConversations_WhenCalledWithRequestAndUserIdIsSetOnFailure_ShouldCallPresenterWithResponse() {
        // Given
        let request = conversationsDataModelMock.getUsersConversationsAction.request
        let userId = dataMock.userId ?? ""
        keychainServiceMock.setUserId(userId)
        let expectedResponse = conversationsDataModelMock.getUsersConversationsAction.responseFailure
        conversationsRepositoryMock.myError = ConversationsDataModelMock.myError

        // When
        sut.getUsersConversations(request: request)

        // Then
        XCTAssertTrue(conversationsPresenterMock.didFailGetUsersConversationsCalled)
        XCTAssertEqual(conversationsPresenterMock.didFailGetUsersConversationsCounter, 1)
        XCTAssertEqual(conversationsPresenterMock.didFailGetUsersConversationsResponse, expectedResponse)
    }
}
