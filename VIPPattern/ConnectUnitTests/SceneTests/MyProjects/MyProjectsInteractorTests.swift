 //
//  MyProjectsInteractorTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 18.06.2022..
//

@testable import Connect
import XCTest

class MyProjectsInteractorTests: XCTestCase {
    private var sut: MyProjectsInteractor!
    private var myProjectsPresenterMock: MyProjectsPresenterMock!
    private var myProjectsDataModelMock: MyProjectsDataModelMock!
    private var projectsRepositoryMock: ProjectsRepositoryMock!
    private var keychainServiceMock: KeychainServiceMock!

    override func setUpWithError() throws {
        myProjectsDataModelMock = MyProjectsDataModelMock()
        myProjectsPresenterMock = MyProjectsPresenterMock()
        projectsRepositoryMock = ProjectsRepositoryMock()
        keychainServiceMock = KeychainServiceMock()
        sut = MyProjectsInteractor(projectsRepository: projectsRepositoryMock,
                                   keychainService: keychainServiceMock)
        sut.presenter = myProjectsPresenterMock
    }

    override func tearDownWithError() throws {
        myProjectsDataModelMock = nil
        myProjectsPresenterMock = nil
        projectsRepositoryMock = nil
        keychainServiceMock = nil
        sut = nil
    }
}

// MARK: GetMyProjectsAction tests
extension MyProjectsInteractorTests {
    func testGetMyProjectsAction_WhenGetMyProjectsCalledWithRequestAndUserIdIsNotSetInKeychain_ShouldNotCallProjectsRepositoryGetProjectsForUser() {
        // Given
        let request = myProjectsDataModelMock.getMyProjectsAction.request
        keychainServiceMock.setUserId(nil)

        // When
        sut.getMyProjects(request: request)

        // Then
        XCTAssertFalse(projectsRepositoryMock.getProjectsForUserCalled)
    }

    func testGetMyProjectsAction_WhenGetMyProjectsCalledWithRequestAndUserIdIsSetInKeychain_ShouldCallProjectsRepositoryGetProjectsForUserWithRequestData() {
        // Given
        let request = myProjectsDataModelMock.getMyProjectsAction.request
        let userId = "user id"
        keychainServiceMock.setUserId(userId)

        // When
        sut.getMyProjects(request: request)

        // Then
        XCTAssertTrue(projectsRepositoryMock.getProjectsForUserCalled)
        XCTAssertEqual(projectsRepositoryMock.getProjectsForUserCounter, 1)
        XCTAssertEqual(projectsRepositoryMock.userId, userId)
    }

    func testGetMyProjectsAction_WhenGetMyProjectsCalledWithRequestAndUserIdIsSetInKeychainOnSuccess_ShouldCallPresenterDidSucceedGetMyProjectsWithResponseSuccess() {
        // Given
        let request = myProjectsDataModelMock.getMyProjectsAction.request
        let userId = "user id"
        keychainServiceMock.setUserId(userId)
        let expectedResponse = myProjectsDataModelMock.getMyProjectsAction.responseSuccess

        // When
        sut.getMyProjects(request: request)

        // Then
        XCTAssertTrue(myProjectsPresenterMock.didSucceedGetMyProjectsCalled)
        XCTAssertEqual(myProjectsPresenterMock.didSucceedGetMyProjectsCounter, 1)
        XCTAssertEqual(myProjectsPresenterMock.didSucceedGetMyProjectsResponse, expectedResponse)
    }

    func testGetMyProjectsAction_WhenGetMyProjectsCalledWithRequestAndUserIdIsSetInKeychainOnFailure_ShouldCallPresenterDidFailGetMyProjectsWithResponseFailure() {
        // Given
        let request = myProjectsDataModelMock.getMyProjectsAction.request
        let userId = "user id"
        keychainServiceMock.setUserId(userId)
        let expectedResponse = myProjectsDataModelMock.getMyProjectsAction.responseFailure
        projectsRepositoryMock.myError = MyProjectsDataModelMock.myError

        // When
        sut.getMyProjects(request: request)

        // Then
        XCTAssertTrue(myProjectsPresenterMock.didFailGetMyProjectsCalled)
        XCTAssertEqual(myProjectsPresenterMock.didFailGetMyProjectsCounter, 1)
        XCTAssertEqual(myProjectsPresenterMock.didFailGetMyProjectsResponse, expectedResponse)
    }
}

// MARK: DeleteProjectAction tests
extension MyProjectsInteractorTests {
    func testDeleteProjectAction_WhenDeleteProjectCalledWithRequest_ShouldCallProjectsRepositoryDeleteProjectWithRequestData() {
        // Given
        let request = myProjectsDataModelMock.deleteProjectAction.request

        // When
        sut.deleteProject(request: request)

        // Then
        XCTAssertTrue(projectsRepositoryMock.deleteProjectCalled)
        XCTAssertEqual(projectsRepositoryMock.deleteProjectCounter, 1)
        XCTAssertEqual(projectsRepositoryMock.projectId, request.projectId)
    }

    func testDeleteProjectAction_WhenDeleteProjectCalledWithRequestOnSuccess_ShouldCallPresenterDidSucceedDeleteProjectWithResponseSuccess() {
        // Given
        let request = myProjectsDataModelMock.deleteProjectAction.request
        let expectedResponse = myProjectsDataModelMock.deleteProjectAction.responseSuccess

        // When
        sut.deleteProject(request: request)

        // Then
        XCTAssertTrue(myProjectsPresenterMock.didSucceedDeleteProjectCalled)
        XCTAssertEqual(myProjectsPresenterMock.didSucceedDeleteProjectCounter, 1)
        XCTAssertEqual(myProjectsPresenterMock.didSucceedDeleteProjectResponse, expectedResponse)
    }

    func testDeleteProjectAction_WhenDeleteProjectCalledWithRequestOnFailure_ShouldCallPresenterDidFailDeleteProjectWithResponseFailure() {
        // Given
        let request = myProjectsDataModelMock.deleteProjectAction.request
        let expectedResponse = myProjectsDataModelMock.deleteProjectAction.responseFailure
        projectsRepositoryMock.myError = MyProjectsDataModelMock.myError

        // When
        sut.deleteProject(request: request)

        // Then
        XCTAssertTrue(myProjectsPresenterMock.didFailDeleteProjectCalled)
        XCTAssertEqual(myProjectsPresenterMock.didFailDeleteProjectCounter, 1)
        XCTAssertEqual(myProjectsPresenterMock.didFailDeleteProjectResponse, expectedResponse)
    }
}
