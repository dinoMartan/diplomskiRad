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
