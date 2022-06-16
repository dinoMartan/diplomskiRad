 //
//  EditProjectPresenterTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect
import XCTest

class EditProjectPresenterTests: XCTestCase {
    private var sut: EditProjectPresenter!
    private var editProjectViewControllerMock: EditProjectViewControllerMock!
    private var editProjectDataModelMock: EditProjectDataModelMock!

    override func setUpWithError() throws {
        editProjectDataModelMock = EditProjectDataModelMock()
        editProjectViewControllerMock = EditProjectViewControllerMock()
        sut = EditProjectPresenter()
        sut.viewController = editProjectViewControllerMock
    }

    override func tearDownWithError() throws {
        editProjectDataModelMock = nil
        editProjectViewControllerMock = nil
        sut = nil
    }
}

// MARK: GetProjectAction tests
extension EditProjectPresenterTests {
    func testDidSucceedGetProject_WhenCalledWithResponse_ShouldCallViewControllerDidSucceedGetProjectWithViewModelSuccess() {
        // Given
        let response = editProjectDataModelMock.getProjectAction.responseSuccess
        let expectedViewModel = editProjectDataModelMock.getProjectAction.viewModelSuccess

        // When
        sut.interactor(didSucceedGetProject: response)

        // Then
        XCTAssertTrue(editProjectViewControllerMock.didSucceedGetProjectCalled)
        XCTAssertEqual(editProjectViewControllerMock.didSucceedGetProjectCounter, 1)
        XCTAssertEqual(editProjectViewControllerMock.didSucceedGetProjectViewModel, expectedViewModel)
    }

    func testDidFailGetProject_WhenCalledWithResponse_ShouldCallViewControllerDidFailGetProjectWithViewModelFailure() {
        // Given
        let response = editProjectDataModelMock.getProjectAction.responseFailure
        let expectedViewModel = editProjectDataModelMock.getProjectAction.viewModelFailure

        // When
        sut.interactor(didFailGetProject: response)

        // Then
        XCTAssertTrue(editProjectViewControllerMock.didFailGetProjectCalled)
        XCTAssertEqual(editProjectViewControllerMock.didFailGetProjectCounter, 1)
        XCTAssertEqual(editProjectViewControllerMock.didFailGetProjectViewModel, expectedViewModel)
    }
}

// MARK: SaveProjectAction tests
extension EditProjectPresenterTests {
    func testDidSucceedSaveProject_WhenCalledWithResponse_ShouldCallViewControllerDidSucceedSaveProjectWithViewModelSuccess() {
        // Given
        let response = editProjectDataModelMock.saveProjectAction.responseSuccess
        let expectedViewModel = editProjectDataModelMock.saveProjectAction.viewModelSuccess

        // When
        sut.interactor(didSucceedSaveProject: response)

        // Then
        XCTAssertTrue(editProjectViewControllerMock.didSucceedSaveProjectCalled)
        XCTAssertEqual(editProjectViewControllerMock.didSucceedSaveProjectCounter, 1)
        XCTAssertEqual(editProjectViewControllerMock.didSucceedSaveProjectViewModel, expectedViewModel)
    }

    func testDidFailSaveProject_WhenCalledWithResponse_ShouldCallViewControllerDidFailSaveProjectWithViewModelFailure() {
        // Given
        let response = editProjectDataModelMock.saveProjectAction.responseFailure
        let expectedViewModel = editProjectDataModelMock.saveProjectAction.viewModelFailure

        // When
        sut.interactor(didFailSaveProject: response)

        // Then
        XCTAssertTrue(editProjectViewControllerMock.didFailSaveProjectCalled)
        XCTAssertEqual(editProjectViewControllerMock.didFailSaveProjectCounter, 1)
        XCTAssertEqual(editProjectViewControllerMock.didFailSaveProjectViewModel, expectedViewModel)
    }
}
