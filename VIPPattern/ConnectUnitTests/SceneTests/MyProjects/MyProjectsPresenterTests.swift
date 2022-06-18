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

// MARK: DeleteProjectAction tests
extension MyProjectsPresenterTests {
    func testDeleteProjectAction_WhenDidSucceedDeleteProjectCalledWithResponseSuccess_ShouldCallViewControllerDidSucceedDeleteProjectWithViewModelSuccess() {
        // Given
        let response = myProjectsDataModelMock.deleteProjectAction.responseSuccess
        let expectedViewModel = myProjectsDataModelMock.deleteProjectAction.viewModelSuccess

        // When
        sut.interactor(didSucceedDeleteProject: response)

        // Then
        XCTAssertTrue(myProjectsViewControllerMock.didSucceedDeleteProjectCalled)
        XCTAssertEqual(myProjectsViewControllerMock.didSucceedDeleteProjectCounter, 1)
        XCTAssertEqual(myProjectsViewControllerMock.didSucceedDeleteProjectViewModel, expectedViewModel)
    }

    func testDeleteProjectAction_WhenDidFailDeleteProjectCalledWithResponseFailure_ShouldCallViewControllerDidFailDeleteProjectWithViewModelFailure() {
        // Given
        let response = myProjectsDataModelMock.deleteProjectAction.responseFailure
        let expectedViewModel = myProjectsDataModelMock.deleteProjectAction.viewModelFailure

        // When
        sut.interactor(didFailDeleteProject: response)

        // Then
        XCTAssertTrue(myProjectsViewControllerMock.didFailDeleteProjectCalled)
        XCTAssertEqual(myProjectsViewControllerMock.didFailDeleteProjectCounter, 1)
        XCTAssertEqual(myProjectsViewControllerMock.didFailDeleteProjectViewModel, expectedViewModel)
    }
}
