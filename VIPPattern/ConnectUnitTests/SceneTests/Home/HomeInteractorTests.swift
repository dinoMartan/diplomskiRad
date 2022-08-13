 //
//  HomeInteractorTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 17.06.2022..
//

@testable import Connect
import XCTest

class HomeInteractorTests: XCTestCase {
    private var sut: HomeInteractor!
    private var homePresenterMock: HomePresenterMock!
    private var homeDataModelMock: HomeDataModelMock!
    private var projectsRepositoryMock: ProjectsRepositoryMock!
    private var dataMock: DataMock!

    override func setUpWithError() throws {
        homeDataModelMock = HomeDataModelMock()
        homePresenterMock = HomePresenterMock()
        projectsRepositoryMock = ProjectsRepositoryMock()
        sut = HomeInteractor(projectsRepository: projectsRepositoryMock)
        sut.presenter = homePresenterMock
        dataMock = DataMock()
    }

    override func tearDownWithError() throws {
        homeDataModelMock = nil
        homePresenterMock = nil
        projectsRepositoryMock = nil
        sut = nil
        dataMock = nil
    }
}

// MARK: GetAllProjectsAction tests
extension HomeInteractorTests {
    func testGetAllProjects_WhenCalledWithRequest_ShouldCallProjectsRepositoryGetAllProjects() {
        // Given
        let request = homeDataModelMock.getAllProjectsAction.request

        // When
        sut.getAllProjects(request: request)

        // Then
        XCTAssertTrue(projectsRepositoryMock.getAllProjectsCalled)
        XCTAssertEqual(projectsRepositoryMock.getAllProjectsCounter, 1)
    }

    func testGetAllProjects_WhenCalledWithRequestOnSuccess_ShouldCallPresenterDidSucceedGetAllProjectsWithResponseSuccess() {
        // Given
        let request = homeDataModelMock.getAllProjectsAction.request
        let expectedResponse = homeDataModelMock.getAllProjectsAction.responseSuccess
        projectsRepositoryMock.expectedResponse = [dataMock.getProject()]

        // When
        sut.getAllProjects(request: request)

        // Then
        XCTAssertTrue(homePresenterMock.didSucceedGetAllProjectsCalled)
        XCTAssertEqual(homePresenterMock.didSucceedGetAllProjectsCounter, 1)
        XCTAssertEqual(homePresenterMock.didSucceedGetAllProjectsResponse, expectedResponse)
    }

    func testGetAllProjects_WhenCalledWithRequestOnFailure_ShouldCallPresenterDidFailGetAllProjectsWithResponseFailure() {
        // Given
        let request = homeDataModelMock.getAllProjectsAction.request
        let expectedResponse = homeDataModelMock.getAllProjectsAction.responseFailure
        projectsRepositoryMock.myError = HomeDataModelMock.myError

        // When
        sut.getAllProjects(request: request)

        // Then
        XCTAssertTrue(homePresenterMock.didFailGetAllProjectsCalled)
        XCTAssertEqual(homePresenterMock.didFailGetAllProjectsCounter, 1)
        XCTAssertEqual(homePresenterMock.didFailGetAllProjectsResponse, expectedResponse)
    }
}

// MARK: GetProjectsWithNeed tests
extension HomeInteractorTests {
    func testGetProjectsWithNeed_WhenCalledWithRequest_ShouldCallProjectsRepositoryGetProjectsWithNeedWithRequestData() {
        // Given
        let request = homeDataModelMock.getProjectsWithNeedAction.request

        // When
        sut.getProjectsWithNeed(request: request)

        // Then
        XCTAssertTrue(projectsRepositoryMock.getProjectsWithNeedForCalled)
        XCTAssertEqual(projectsRepositoryMock.getProjectsWithNeedForCounter, 1)
        XCTAssertEqual(projectsRepositoryMock.need, request.need)
    }

    func testGetProjectsWithNeed_WhenCalledWithRequestOnSuccess_ShouldCallPresenterDidSucceedGetProjectsWithNeedWithResponseSuccess() {
        // Given
        let request = homeDataModelMock.getProjectsWithNeedAction.request
        let expectedResponse = homeDataModelMock.getProjectsWithNeedAction.responseSuccess
        projectsRepositoryMock.expectedResponse = [dataMock.getProject()]

        // When
        sut.getProjectsWithNeed(request: request)

        // Then
        XCTAssertTrue(homePresenterMock.didSucceedGetProjectsWithNeedCalled)
        XCTAssertEqual(homePresenterMock.didSucceedGetProjectsWithNeedCounter, 1)
        XCTAssertEqual(homePresenterMock.didSucceedGetProjectsWithNeedResponse, expectedResponse)
    }

    func testGetProjectsWithNeed_WhenCalledWithRequestOnFailure_ShouldCallPresenterDidFailGetProjectsWithNeedWithResponseFailure() {
        // Given
        let request = homeDataModelMock.getProjectsWithNeedAction.request
        let expectedResponse = homeDataModelMock.getProjectsWithNeedAction.responseFailure
        projectsRepositoryMock.myError = HomeDataModelMock.myError

        // When
        sut.getProjectsWithNeed(request: request)

        // Then
        XCTAssertTrue(homePresenterMock.didFailGetProjectsWithNeedCalled)
        XCTAssertEqual(homePresenterMock.didFailGetProjectsWithNeedCounter, 1)
        XCTAssertEqual(homePresenterMock.didFailGetProjectsWithNeedResponse, expectedResponse)
    }
}
