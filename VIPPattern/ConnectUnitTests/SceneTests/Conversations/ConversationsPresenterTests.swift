 //
//  ConversationsPresenterTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 11.08.2022..
//

@testable import Connect
import XCTest

class ConversationsPresenterTests: XCTestCase {
    private var sut: ConversationsPresenter!
    private var conversationsViewControllerMock: ConversationsViewControllerMock!
    private var conversationsDataModelMock: ConversationsDataModelMock!

    override func setUpWithError() throws {
        conversationsDataModelMock = ConversationsDataModelMock()
        conversationsViewControllerMock = ConversationsViewControllerMock()
        sut = ConversationsPresenter()
        sut.viewController = conversationsViewControllerMock
    }

    override func tearDownWithError() throws {
        conversationsDataModelMock = nil
        conversationsViewControllerMock = nil
        sut = nil
    }
}

// MARK: interactor(didSucceedGetUsersConversations response: Conversations.GetUsersConversationsAction.Response.Success) test
extension ConversationsPresenterTests {
    func testDidSucceedGetUsersConversations_WhenCalledWithResponse_ShouldCallViewControllerWithViewModel() {
        // Given
        let response = conversationsDataModelMock.getUsersConversationsAction.responseSuccess
        let expectedViewModel = conversationsDataModelMock.getUsersConversationsAction.viewModelSuccess

        // When
        sut.interactor(didSucceedGetUsersConversations: response)

        // Then
        XCTAssertTrue(conversationsViewControllerMock.didSucceedGetUsersConversationsCalled)
        XCTAssertEqual(conversationsViewControllerMock.didSucceedGetUsersConversationsCounter, 1)
        XCTAssertEqual(conversationsViewControllerMock.didSucceedGetUsersConversationsViewModel, expectedViewModel)
    }
}

// MARK: interactor(didFailGetUsersConversations response: Conversations.GetUsersConversationsAction.Response.Failure) test
extension ConversationsPresenterTests {
    func testDidFailGetUsersConversations_WhenCalledWithResponse_ShouldCallViewControllerWithViewModel() {
        // Given
        let response = conversationsDataModelMock.getUsersConversationsAction.responseFailure
        let expectedViewModel = conversationsDataModelMock.getUsersConversationsAction.viewModelFailure

        // When
        sut.interactor(didFailGetUsersConversations: response)

        // Then
        XCTAssertTrue(conversationsViewControllerMock.didFailGetUsersConversationsCalled)
        XCTAssertEqual(conversationsViewControllerMock.didFailGetUsersConversationsCounter, 1)
        XCTAssertEqual(conversationsViewControllerMock.didFailGetUsersConversationsViewModel, expectedViewModel)
    }
}
