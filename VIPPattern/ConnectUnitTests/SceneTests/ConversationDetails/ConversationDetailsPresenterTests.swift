 //
//  ConversationDetailsPresenterTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.08.2022..
//

@testable import Connect
import XCTest

class ConversationDetailsPresenterTests: XCTestCase {
    private var sut: ConversationDetailsPresenter!
    private var conversationDetailsViewControllerMock: ConversationDetailsViewControllerMock!
    private var conversationDetailsDataModelMock: ConversationDetailsDataModelMock!

    override func setUpWithError() throws {
        conversationDetailsDataModelMock = ConversationDetailsDataModelMock()
        conversationDetailsViewControllerMock = ConversationDetailsViewControllerMock()
        sut = ConversationDetailsPresenter()
        sut.viewController = conversationDetailsViewControllerMock
    }

    override func tearDownWithError() throws {
        conversationDetailsDataModelMock = nil
        conversationDetailsViewControllerMock = nil
        sut = nil
    }
}

// MARK: interactor(didSucceedGetConversation response: ConversationDetails.GetConversationAction.Response.Success) test
extension ConversationDetailsPresenterTests {
    func testDidSucceedGetConversation_WhenCalledWithResponse_ShouldCallViewControllerDidSucceedGetConversationWithViewModel() {
        // Given
        let response = conversationDetailsDataModelMock.getConversationAction.responseSuccess
        let expectedViewModel = conversationDetailsDataModelMock.getConversationAction.viewModelSuccess

        // When
        sut.interactor(didSucceedGetConversation: response)

        // Then
        XCTAssertTrue(conversationDetailsViewControllerMock.didSucceedGetConversationCalled)
        XCTAssertEqual(conversationDetailsViewControllerMock.didSucceedGetConversationCounter, 1)
        XCTAssertEqual(conversationDetailsViewControllerMock.didSucceedGetConversationViewModel, expectedViewModel)
    }
}

// MARK: interactor(didFailGetConversation response: ConversationDetails.GetConversationAction.Response.Failure) test
extension ConversationDetailsPresenterTests {
    func testDidFailGetConversation_WhenCalledWithResponse_ShouldCallViewControllerDidFailGetConversationWithViewModel() {
        // Given
        let response = conversationDetailsDataModelMock.getConversationAction.responseFailure
        let expectedViewModel = conversationDetailsDataModelMock.getConversationAction.viewModelFailure

        // When
        sut.interactor(didFailGetConversation: response)

        // Then
        XCTAssertTrue(conversationDetailsViewControllerMock.didFailGetConversationCalled)
        XCTAssertEqual(conversationDetailsViewControllerMock.didFailGetConversationCounter, 1)
        XCTAssertEqual(conversationDetailsViewControllerMock.didFailGetConversationViewModel, expectedViewModel)
    }
}

// MARK: interactor(didSucceedSendMessage response: ConversationDetails.SendMessageAction.Response.Success) test
extension ConversationDetailsPresenterTests {
    func testDidSucceedSendMessage_WhenCalledWithResponse_ShouldCallViewControllerDidSucceedSendMessageWithViewModel() {
        // Given
        let response = conversationDetailsDataModelMock.sendMessageAction.responseSuccess
        let expectedViewModel = conversationDetailsDataModelMock.sendMessageAction.viewModelSuccess

        // When
        sut.interactor(didSucceedSendMessage: response)

        // Then
        XCTAssertTrue(conversationDetailsViewControllerMock.didSucceedSendMessageCalled)
        XCTAssertEqual(conversationDetailsViewControllerMock.didSucceedSendMessageCounter, 1)
        XCTAssertEqual(conversationDetailsViewControllerMock.didSucceedSendMessageViewModel, expectedViewModel)
    }
}

// MARK: interactor(didFailSendMessage response: ConversationDetails.SendMessageAction.Response.Failure) test
extension ConversationDetailsPresenterTests {
    func testDidFailSendMessage_WhenCalledWithResponse_ShouldCallViewControllerDidFailSendMessageWithViewModel() {
        // Given
        let response = conversationDetailsDataModelMock.sendMessageAction.responseFailure
        let expectedViewModel = conversationDetailsDataModelMock.sendMessageAction.viewModelFailure

        // When
        sut.interactor(didFailSendMessage: response)

        // Then
        XCTAssertTrue(conversationDetailsViewControllerMock.didFailSendMessageCalled)
        XCTAssertEqual(conversationDetailsViewControllerMock.didFailSendMessageCounter, 1)
        XCTAssertEqual(conversationDetailsViewControllerMock.didFailSendMessageViewModel, expectedViewModel)
    }
}
