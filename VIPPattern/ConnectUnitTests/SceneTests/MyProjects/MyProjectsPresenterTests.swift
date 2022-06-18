 //
//  MyProjectsPresenterTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 18.06.2022..
//

@testable import Connect
import XCTest

class MyProjectsPresenterTests: XCTestCase {
    private var sut: MyProjectsPresenter!
    private var myProjectsViewControllerMock: MyProjectsViewControllerMock!
    private var myProjectsDataModelMock: MyProjectsDataModelMock!

    override func setUpWithError() throws {
        myProjectsDataModelMock = MyProjectsDataModelMock()
        myProjectsViewControllerMock = MyProjectsViewControllerMock()
        sut = MyProjectsPresenter()
        sut.viewController = myProjectsViewControllerMock
    }

    override func tearDownWithError() throws {
        myProjectsDataModelMock = nil
        myProjectsViewControllerMock = nil
        sut = nil
    }
}

// MARK: GetMyProjectsAction tests
extension MyProjectsPresenterTests {
    func testGetMyProjectsAction_WhenDidSucceedGetMyProjectsCalledWithResponseSuccess_ShouldCallViewControllerDidSucceedGetMyProjectsWithViewModelSuccess() {
        // Given
        let response = myProjectsDataModelMock.getMyProjectsAction.responseSuccess
        let expectedViewModel = myProjectsDataModelMock.getMyProjectsAction.viewModelSuccess

        // When
        sut.interactor(didSucceedGetMyProjects: response)

        // Then
        XCTAssertTrue(myProjectsViewControllerMock.didSucceedGetMyProjectsCalled)
        XCTAssertEqual(myProjectsViewControllerMock.didSucceedGetMyProjectsCounter, 1)
        XCTAssertEqual(myProjectsViewControllerMock.didSucceedGetMyProjectsViewModel, expectedViewModel)
    }

    func testGetMyProjectsAction_WhenDidFailGetMyProjectsCalledWithResponseFailure_ShouldCallViewControllerDidFailGetMyProjectsWithViewModelFailure() {
        // Given
        let response = myProjectsDataModelMock.getMyProjectsAction.responseFailure
        let expectedViewModel = myProjectsDataModelMock.getMyProjectsAction.viewModelFailure

        // When
        sut.interactor(didFailGetMyProjects: response)

        // Then
        XCTAssertTrue(myProjectsViewControllerMock.didFailGetMyProjectsCalled)
        XCTAssertEqual(myProjectsViewControllerMock.didFailGetMyProjectsCounter, 1)
        XCTAssertEqual(myProjectsViewControllerMock.didFailGetMyProjectsViewModel, expectedViewModel)
    }
}
