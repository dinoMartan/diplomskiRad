 //
//  ProjectDetailsPresenterTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 19.06.2022..
//

@testable import Connect
import XCTest

class ProjectDetailsPresenterTests: XCTestCase {
    private var sut: ProjectDetailsPresenter!
    private var projectDetailsViewControllerMock: ProjectDetailsViewControllerMock!
    private var projectDetailsDataModelMock: ProjectDetailsDataModelMock!

    override func setUpWithError() throws {
        projectDetailsDataModelMock = ProjectDetailsDataModelMock()
        projectDetailsViewControllerMock = ProjectDetailsViewControllerMock()
        sut = ProjectDetailsPresenter()
        sut.viewController = projectDetailsViewControllerMock
    }

    override func tearDownWithError() throws {
        projectDetailsDataModelMock = nil
        projectDetailsViewControllerMock = nil
        sut = nil
    }
}

// MARK: GetProjectDetailsAction tests
extension ProjectDetailsPresenterTests {
    func testGetProjectDetailsAction_WhenDidSucceedGetProjectDetailsCalledWithResponseSuccess_ShouldCallViewControllerDidSucceedGetProjectDetailsWithViewModelSuccess() {
        // Given
        let response = projectDetailsDataModelMock.getProjectDetailsAction.responseSuccess
        let expectedViewModel = projectDetailsDataModelMock.getProjectDetailsAction.viewModelSuccess

        // When
        sut.interactor(didSucceedGetProjectDetails: response)

        // Then
        XCTAssertTrue(projectDetailsViewControllerMock.didSucceedGetProjectDetailsCalled)
        XCTAssertEqual(projectDetailsViewControllerMock.didSucceedGetProjectDetailsCounter, 1)
        XCTAssertEqual(projectDetailsViewControllerMock.didSucceedGetProjectDetailsViewModel, expectedViewModel)
    }

    func testGetProjectDetailsAction_WhenDidFailGetProjectDetailsCalledWithResponseFailure_ShouldCallViewControllerDidFailGetProjectDetailsWithViewModelFailure() {
        // Given
        let response = projectDetailsDataModelMock.getProjectDetailsAction.responseFailure
        let expectedViewModel = projectDetailsDataModelMock.getProjectDetailsAction.viewModelFailure

        // When
        sut.interactor(didFailGetProjectDetails: response)

        // Then
        XCTAssertTrue(projectDetailsViewControllerMock.didFailGetProjectDetailsCalled)
        XCTAssertEqual(projectDetailsViewControllerMock.didFailGetProjectDetailsCounter, 1)
        XCTAssertEqual(projectDetailsViewControllerMock.didFailGetProjectDetailsViewModel, expectedViewModel)
    }
}
