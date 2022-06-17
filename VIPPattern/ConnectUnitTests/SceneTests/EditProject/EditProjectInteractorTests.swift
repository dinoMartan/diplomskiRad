 //
//  EditProjectInteractorTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect
import XCTest

class EditProjectInteractorTests: XCTestCase {
    private var sut: EditProjectInteractor!
    private var editProjectPresenterMock: EditProjectPresenterMock!
    private var editProjectDataModelMock: EditProjectDataModelMock!
    private var projectsRepositoryMock: ProjectsRepositoryMock!
    private var keychainServiceMock: KeychainServiceMock!
    private var userRepositoryMock: UserRepositoryMock!
    private var dataMock: DataMock!
    private var projectId: String? = "project id"

    override func setUpWithError() throws {
        editProjectDataModelMock = EditProjectDataModelMock()
        editProjectPresenterMock = EditProjectPresenterMock()
        projectsRepositoryMock = ProjectsRepositoryMock()
        keychainServiceMock = KeychainServiceMock()
        userRepositoryMock = UserRepositoryMock()
        dataMock = DataMock()
        sut = EditProjectInteractor(projectId: projectId,
                                    projectsRepository: projectsRepositoryMock,
                                    userRepository: userRepositoryMock,
                                    keychainService: keychainServiceMock)
        sut.presenter = editProjectPresenterMock
    }

    override func tearDownWithError() throws {
        editProjectDataModelMock = nil
        editProjectPresenterMock = nil
        projectsRepositoryMock = nil
        keychainServiceMock = nil
        userRepositoryMock = nil
        dataMock = nil
        sut = nil
    }
}

// MARK: GetProjectAction tests
extension EditProjectInteractorTests {
    func testGetProject_WhenCalledWithRequestAndProjectIdIsSet_ShouldCallProjectsRepositoryGetProjectWithProjectId() {
        // Given
        let request = editProjectDataModelMock.getProjectAction.request

        // When
        sut.getProject(request: request)

        // Then
        XCTAssertTrue(projectsRepositoryMock.getProjectCalled)
        XCTAssertEqual(projectsRepositoryMock.getProjectCounter, 1)
        XCTAssertEqual(projectsRepositoryMock.projectId, projectId)
    }

    func testGetProject_WhenCalledWithRequestAndProjectIdIsNotSet_ShouldNotCallProjectsRepositoryGetProject() {
        // Given
        sut = EditProjectInteractor(projectId: nil,
                                    projectsRepository: projectsRepositoryMock,
                                    userRepository: userRepositoryMock,
                                    keychainService: keychainServiceMock)
        let request = editProjectDataModelMock.getProjectAction.request

        // When
        sut.getProject(request: request)

        // Then
        XCTAssertFalse(projectsRepositoryMock.getProjectCalled)
    }

    func testGetProject_WhenCalledWithRequestAndProjectIdIsSetOnSuccess_ShouldCallPresenterDidSucceedGetProjectWithResponseSuccess() {
        // Given
        let request = editProjectDataModelMock.getProjectAction.request
        let expectedResponse = editProjectDataModelMock.getProjectAction.responseSuccess

        // When
        sut.getProject(request: request)

        // Then
        XCTAssertTrue(editProjectPresenterMock.didSucceedGetProjectCalled)
        XCTAssertEqual(editProjectPresenterMock.didSucceedGetProjectCounter, 1)
        XCTAssertEqual(editProjectPresenterMock.didSucceedGetProjectResponse, expectedResponse)
    }

    func testGetProject_WhenCalledWithRequestAndProjectIdIsSetOnFailure_ShouldCallPresenterDidFailGetProjectWithResponseFailure() {
        // Given
        let request = editProjectDataModelMock.getProjectAction.request
        let expectedResponse = editProjectDataModelMock.getProjectAction.responseFailure
        projectsRepositoryMock.myError = EditProjectDataModelMock.myError

        // When
        sut.getProject(request: request)

        // Then
        XCTAssertTrue(editProjectPresenterMock.didFailGetProjectCalled)
        XCTAssertEqual(editProjectPresenterMock.didFailGetProjectCounter, 1)
        XCTAssertEqual(editProjectPresenterMock.didFailGetProjectResponse, expectedResponse)
    }
}

// MARK: SaveProjectAction tests
extension EditProjectInteractorTests {
    func testSaveProject_WhenCalledWithCurrentProjectSet_ShouldUpdateCurrentProjectWithRequestDataAndCallProjectsRepositorySetProjectWithCurrentProject() {
        // Given
        let getCurrentProjectRequest = editProjectDataModelMock.getProjectAction.request
        sut.getProject(request: getCurrentProjectRequest)
        let request = editProjectDataModelMock.saveProjectAction.request
        let expectedTitle = request.title
        let expectedDescription = request.description
        let expectedHaveTags = request.haveTags
        let expectedNeedTags = request.needTags

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertTrue(projectsRepositoryMock.setProjectCalled)
        XCTAssertEqual(projectsRepositoryMock.setProjectCounter, 1)
        XCTAssertEqual(projectsRepositoryMock.project?.title, expectedTitle)
        XCTAssertEqual(projectsRepositoryMock.project?.description, expectedDescription)
        XCTAssertEqual(projectsRepositoryMock.project?.haveTags, expectedHaveTags)
        XCTAssertEqual(projectsRepositoryMock.project?.needTags, expectedNeedTags)
    }

    func testSaveProject_WhenCalledWithCurrentProjectSetOnSuccess_ShouldCallPresenterDidSucceedSaveProjectWithResponseSuccess() {
        // Given
        let getCurrentProjectRequest = editProjectDataModelMock.getProjectAction.request
        sut.getProject(request: getCurrentProjectRequest)
        let request = editProjectDataModelMock.saveProjectAction.request
        let expectedResponse = editProjectDataModelMock.saveProjectAction.responseSuccess

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertTrue(editProjectPresenterMock.didSucceedSaveProjectCalled)
        XCTAssertEqual(editProjectPresenterMock.didSucceedSaveProjectCounter, 1)
        XCTAssertEqual(editProjectPresenterMock.didSucceedSaveProjectResponse, expectedResponse)
    }

    func testSaveProject_WhenCalledWithCurrentProjectSetOnFailure_ShouldCallPresenterDidFaileSaveProjectWithResponseFailure() {
        // Given
        let getCurrentProjectRequest = editProjectDataModelMock.getProjectAction.request
        sut.getProject(request: getCurrentProjectRequest)
        let request = editProjectDataModelMock.saveProjectAction.request
        let expectedResponse = editProjectDataModelMock.saveProjectAction.responseFailure
        projectsRepositoryMock.myError = EditProjectDataModelMock.myError

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertTrue(editProjectPresenterMock.didFailSaveProjectCalled)
        XCTAssertEqual(editProjectPresenterMock.didFailSaveProjectCounter, 1)
        XCTAssertEqual(editProjectPresenterMock.didFailSaveProjectResponse, expectedResponse)
    }

    func testSaveProject_WhenCalledWithCurrentProjectNotSetAndUserIdNotSetInKeychain_ShouldNotCallUserRepositoryGetUser() {
        // Given
        let request = editProjectDataModelMock.saveProjectAction.request

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertFalse(userRepositoryMock.getUserCalled)
    }

    func testSaveProject_WhenCalledWithCurrentProjectNotSetAndUserIdSetInKeychain_ShouldCallPresenterDidFailSaveProjectWithResponseFailure() {
        // Given
        let request = editProjectDataModelMock.saveProjectAction.request
        let myError = MyError(type: nil, message: nil)
        let expectedResponse = EditProject.SaveProjectAction.Response.Failure(myError: myError)

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertTrue(editProjectPresenterMock.didFailSaveProjectCalled)
        XCTAssertEqual(editProjectPresenterMock.didFailSaveProjectCounter, 1)
        XCTAssertEqual(editProjectPresenterMock.didFailSaveProjectResponse, expectedResponse)
    }

    func testSaveProject_WhenCalledWithCurrentProjectNotSetAndUserIdSetInKeychain_ShouldCallUserRepositoryGetUserWithUserId() {
        // Given
        let userId = "user id"
        keychainServiceMock.setUserId(userId)
        let request = editProjectDataModelMock.saveProjectAction.request

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertTrue(userRepositoryMock.getUserCalled)
        XCTAssertEqual(userRepositoryMock.getUserCounter, 1)
        XCTAssertEqual(userRepositoryMock.userId, userId)
    }

    func testSaveProject_WhenCalledWithCurrentProjectNotSetAndUserIdSetInKeychainOnFailure_ShouldCallPresenterDidFailSaveProjectWithResponseFailure() {
        // Given
        let userId = "user id"
        keychainServiceMock.setUserId(userId)
        let request = editProjectDataModelMock.saveProjectAction.request
        let expectedResponse = editProjectDataModelMock.saveProjectAction.responseFailure
        userRepositoryMock.myError = EditProjectDataModelMock.myError

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertTrue(editProjectPresenterMock.didFailSaveProjectCalled)
        XCTAssertEqual(editProjectPresenterMock.didFailSaveProjectCounter, 1)
        XCTAssertEqual(editProjectPresenterMock.didFailSaveProjectResponse, expectedResponse)
    }

    func testSaveProject_WhenCalledWithCurrentProjectNotSetAndUserIdSetInKeychainOnSuccess_ShouldCreateCurrentProjectWithRequestDataAndUserDataAndCallProjectsRepositorySetProjectWithCurrentProject() {
        // Given
        let userId = "user id"
        keychainServiceMock.setUserId(userId)
        let request = editProjectDataModelMock.saveProjectAction.request
        let expectedTitle = request.title
        let expectedDescription = request.description
        let expectedHaveTags = request.haveTags
        let expectedNeedTags = request.needTags
        let expectedOwner = dataMock.getUser().getUserNested()

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertTrue(projectsRepositoryMock.setProjectCalled)
        XCTAssertEqual(projectsRepositoryMock.setProjectCounter, 1)
        XCTAssertEqual(projectsRepositoryMock.project?.title, expectedTitle)
        XCTAssertEqual(projectsRepositoryMock.project?.description, expectedDescription)
        XCTAssertEqual(projectsRepositoryMock.project?.haveTags, expectedHaveTags)
        XCTAssertEqual(projectsRepositoryMock.project?.needTags, expectedNeedTags)
        XCTAssertEqual(projectsRepositoryMock.project?.owner, expectedOwner)
    }

    func testSaveProject_WhenCalledWithCurrentProjectNotSetAndUserIdSetInKeychainOnSuccess_ShouldCreateCurrentProjectWithRequestDataAndUserDataAndCallProjectsRepositoryOnSuccess_ShouldCallPresenterDidSucceedSaveProjectWithResponseSuccess() {
        // Given
        let userId = "user id"
        keychainServiceMock.setUserId(userId)
        let request = editProjectDataModelMock.saveProjectAction.request
        let expectedResponse = editProjectDataModelMock.saveProjectAction.responseSuccess

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertTrue(editProjectPresenterMock.didSucceedSaveProjectCalled)
        XCTAssertEqual(editProjectPresenterMock.didSucceedSaveProjectCounter, 1)
        XCTAssertEqual(editProjectPresenterMock.didSucceedSaveProjectResponse, expectedResponse)
    }

    func testSaveProject_WhenCalledWithCurrentProjectNotSetAndUserIdSetInKeychainOnSuccess_ShouldCreateCurrentProjectWithRequestDataAndUserDataAndCallProjectsRepositoryOnFailure_ShouldCallPresenterDidFailSaveProjectWithResponseFailure() {
        // Given
        let userId = "user id"
        keychainServiceMock.setUserId(userId)
        let request = editProjectDataModelMock.saveProjectAction.request
        let expectedResponse = editProjectDataModelMock.saveProjectAction.responseFailure
        projectsRepositoryMock.myError = EditProjectDataModelMock.myError

        // When
        sut.saveProject(request: request)

        // Then
        XCTAssertTrue(editProjectPresenterMock.didFailSaveProjectCalled)
        XCTAssertEqual(editProjectPresenterMock.didFailSaveProjectCounter, 1)
        XCTAssertEqual(editProjectPresenterMock.didFailSaveProjectResponse, expectedResponse)
    }
}
