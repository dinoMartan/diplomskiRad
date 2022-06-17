 //
//  HomePresenterTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 17.06.2022..
//

@testable import Connect
import XCTest

class HomePresenterTests: XCTestCase {
    private var sut: HomePresenter!
    private var homeViewControllerMock: HomeViewControllerMock!
    private var homeDataModelMock: HomeDataModelMock!

    override func setUpWithError() throws {
        homeDataModelMock = HomeDataModelMock()
        homeViewControllerMock = HomeViewControllerMock()
        sut = HomePresenter()
        sut.viewController = homeViewControllerMock
    }

    override func tearDownWithError() throws {
        homeDataModelMock = nil
        homeViewControllerMock = nil
        sut = nil
    }
}

// MARK: GetAllProjectsAction tests
extension HomePresenterTests {
    func testDidSucceedGetAllProjects_WhenCalledWithResponse_ShouldCallViewControllerDidSucceedGetAllProjectsWithViewModelSuccess() {
        // Given
        let response = homeDataModelMock.getAllProjectsAction.responseSuccess
        let expectedViewModel = homeDataModelMock.getAllProjectsAction.viewModelSuccess

        // When
        sut.interactor(didSucceedGetAllProjects: response)

        // Then
        XCTAssertTrue(homeViewControllerMock.didSucceedGetAllProjectsCalled)
        XCTAssertEqual(homeViewControllerMock.didSucceedGetAllProjectsCounter, 1)
        XCTAssertEqual(homeViewControllerMock.didSucceedGetAllProjectsViewModel, expectedViewModel)
    }

    func testDidFailGetAllProjects_WhenCalledWithResponse_ShouldCallViewControllerDidFailGetAllProjectsWithViewModelFailure() {
        // Given
        let response = homeDataModelMock.getAllProjectsAction.responseFailure
        let expectedViewModel = homeDataModelMock.getAllProjectsAction.viewModelFailure

        // When
        sut.interactor(didFailGetAllProjects: response)

        // Then
        XCTAssertTrue(homeViewControllerMock.didFailGetAllProjectsCalled)
        XCTAssertEqual(homeViewControllerMock.didFailGetAllProjectsCounter, 1)
        XCTAssertEqual(homeViewControllerMock.didFailGetAllProjectsViewModel, expectedViewModel)
    }
}
