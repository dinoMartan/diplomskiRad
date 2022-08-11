 //
//  ProjectDetailsInteractorTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 19.06.2022..
//

@testable import Connect
import XCTest

class ProjectDetailsInteractorTests: XCTestCase {
    private var sut: ProjectDetailsInteractor!
    private var projectDetailsPresenterMock: ProjectDetailsPresenterMock!
    private var projectDetailsDataModelMock: ProjectDetailsDataModelMock!
    private var projectsRepositoryMock: ProjectsRepositoryMock!
    private var userRepositoryMock: UserRepositoryMock!
    private var keychainServiceMock: KeychainServiceMock!
    private var conversationsRepositoryMock: ConversationsRepositoryMock!
    private let projectId = "project id"

    override func setUpWithError() throws {
        projectDetailsDataModelMock = ProjectDetailsDataModelMock()
        projectDetailsPresenterMock = ProjectDetailsPresenterMock()
        projectsRepositoryMock = ProjectsRepositoryMock()
        userRepositoryMock = UserRepositoryMock()
        keychainServiceMock = KeychainServiceMock()
        conversationsRepositoryMock = ConversationsRepositoryMock()
        sut = ProjectDetailsInteractor(projectsRepository: projectsRepositoryMock,
                                       userRepository: userRepositoryMock,
                                       keychainService: keychainServiceMock,
                                       conversationsRepository: conversationsRepositoryMock,
                                       projectId: projectId)
        sut.presenter = projectDetailsPresenterMock
    }

    override func tearDownWithError() throws {
        projectDetailsDataModelMock = nil
        projectDetailsPresenterMock = nil
        userRepositoryMock = nil
        keychainServiceMock = nil
        conversationsRepositoryMock = nil
        sut = nil
    }
}

// MARK: GetProjectDetailsAction tests
extension ProjectDetailsInteractorTests {
    func testGetProjectDetailsAction_WhenGetProjectDetailsCalledWithRequest_ShouldCallProjectsRepositoryGetProjectWithPresetProjectId() {
        // Given
        let request = projectDetailsDataModelMock.getProjectDetailsAction.request

        // When
        sut.getProjectDetails(request: request)

        // Then
        XCTAssertTrue(projectsRepositoryMock.getProjectCalled)
        XCTAssertEqual(projectsRepositoryMock.getProjectCounter, 1)
        XCTAssertEqual(projectsRepositoryMock.projectId, projectId)
    }

    func testGetProjectDetailsAction_WhenGetProjectDetailsCalledWithRequestOnSuccess_ShouldCallPresenterDidSucceedGetProjectDetailsWithResponseSuccess() {
        // Given
        let request = projectDetailsDataModelMock.getProjectDetailsAction.request
        let expectedResponse = projectDetailsDataModelMock.getProjectDetailsAction.responseSuccess

        // When
        sut.getProjectDetails(request: request)

        // Then
        XCTAssertTrue(projectDetailsPresenterMock.didSucceedGetProjectDetailsCalled)
        XCTAssertEqual(projectDetailsPresenterMock.didSucceedGetProjectDetailsCounter, 1)
        XCTAssertEqual(projectDetailsPresenterMock.didSucceedGetProjectDetailsResponse, expectedResponse)
    }

    func testGetProjectDetailsAction_WhenGetProjectDetailsCalledWithRequestOnFailure_ShouldCallPresenterDidFailGetProjectDetailsWithResponseFailure() {
        // Given
        let request = projectDetailsDataModelMock.getProjectDetailsAction.request
        let expectedResponse = projectDetailsDataModelMock.getProjectDetailsAction.responseFailure
        projectsRepositoryMock.myError = ProjectDetailsDataModelMock.myError

        // When
        sut.getProjectDetails(request: request)

        // Then
        XCTAssertTrue(projectDetailsPresenterMock.didFailGetProjectDetailsCalled)
        XCTAssertEqual(projectDetailsPresenterMock.didFailGetProjectDetailsCounter, 1)
        XCTAssertEqual(projectDetailsPresenterMock.didFailGetProjectDetailsResponse, expectedResponse)
    }
}
