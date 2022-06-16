 //
//  ProfileInteractorTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect
import XCTest

class ProfileInteractorTests: XCTestCase {
    private var sut: ProfileInteractor!
    private var profilePresenterMock: ProfilePresenterMock!
    private var profileDataModelMock: ProfileDataModelMock!
    private var keychainServiceMock: KeychainServiceMock!
    private var userRepositoryMock: UserRepositoryMock!

    override func setUpWithError() throws {
        profileDataModelMock = ProfileDataModelMock()
        profilePresenterMock = ProfilePresenterMock()
        keychainServiceMock = KeychainServiceMock()
        userRepositoryMock = UserRepositoryMock()
        sut = ProfileInteractor(userRepository: userRepositoryMock,
                                keychainService: keychainServiceMock)
        sut.presenter = profilePresenterMock
    }

    override func tearDownWithError() throws {
        profileDataModelMock = nil
        profilePresenterMock = nil
        keychainServiceMock = nil
        userRepositoryMock = nil
        sut = nil
    }
}

// MARK: GetUserDataAction tests
extension ProfileInteractorTests {
    func testGetUserData_WhenCalledWithRequest_andUserIdIsNotInKeychain_ShouldNotCallUserRepositoryGetUser() {
        // Given
        let request = profileDataModelMock.getUserDataAction.request
        keychainServiceMock.setUserId(nil)

        // When
        sut.getUserData(request: request)

        // Then
        XCTAssertFalse(userRepositoryMock.getUserCalled)
    }

    func testGetUserData_WhenCalledWithRequest_andUserIdIsInKeychain_ShouldCallUserRepositoryGetUserWithRequestData() {
        // Given
        let request = profileDataModelMock.getUserDataAction.request
        let userId = "user id"
        keychainServiceMock.setUserId(userId)

        // When
        sut.getUserData(request: request)

        // Then
        XCTAssertTrue(userRepositoryMock.getUserCalled)
        XCTAssertEqual(userRepositoryMock.getUserCounter, 1)
        XCTAssertEqual(userRepositoryMock.userId, userId)
    }

    func testGetUserData_WhenCalledWithRequest_andUserIdIsInKeychainOnSuccess_ShouldCallPresenterDidSucceedGetUserDataWithResponseSuccess() {
        // Given
        let request = profileDataModelMock.getUserDataAction.request
        let userId = "user id"
        let expectedResponse = profileDataModelMock.getUserDataAction.responseSuccess
        keychainServiceMock.setUserId(userId)

        // When
        sut.getUserData(request: request)

        // Then
        XCTAssertTrue(profilePresenterMock.didSucceedGetUserDataCalled)
        XCTAssertEqual(profilePresenterMock.didSucceedGetUserDataCounter, 1)
        XCTAssertEqual(profilePresenterMock.didSucceedGetUserDataResponse, expectedResponse)
    }

    func testGetUserData_WhenCalledWithRequest_andUserIdIsInKeychainOnFailure_ShouldCallPresenterDidFailGetUserDataWithResponseFailure() {
        // Given
        let request = profileDataModelMock.getUserDataAction.request
        let userId = "user id"
        let expectedResponse = profileDataModelMock.getUserDataAction.responseFailure
        keychainServiceMock.setUserId(userId)
        userRepositoryMock.myError = ProfileDataModelMock.myError

        // When
        sut.getUserData(request: request)

        // Then
        XCTAssertTrue(profilePresenterMock.didFailGetUserDataCalled)
        XCTAssertEqual(profilePresenterMock.didFailGetUserDataCounter, 1)
        XCTAssertEqual(profilePresenterMock.didFailGetUserDataResponse, expectedResponse)
    }
}

// MARK: UpdateSettingAction tests
extension ProfileInteractorTests {
    func testUpdateSetting_WhenCalledWithRequestAndUserWasNotFetched_ShouldNotCallUserRepositorySetUser() {
        // Given
        let request = profileDataModelMock.updateSettingAction.request

        // When
        sut.updateSetting(request: request)

        // Then
        XCTAssertFalse(userRepositoryMock.setUserCalled)
        XCTAssertEqual(userRepositoryMock.setUserCounter, 0)
    }

    func testUpdateSetting_WhenCalledWithRequestAndUserWasFetched_ShouldCallUserRepositorySetUserWithRequestData() {
        // Given
        let request = profileDataModelMock.updateSettingAction.request
        let getUserDataRequest = profileDataModelMock.getUserDataAction.request
        keychainServiceMock.setUserId("user id")
        sut.getUserData(request: getUserDataRequest)

        // When
        sut.updateSetting(request: request)

        // Then
        XCTAssertTrue(userRepositoryMock.setUserCalled)
        XCTAssertEqual(userRepositoryMock.setUserCounter, 1)
    }

    func testUpdateSetting_WhenCalledWithRequestAndUserWasFetchedOnSuccess_ShouldCallPresenterDidSucceedUpdateSettingWithResponseSuccess() {
        // Given
        let request = profileDataModelMock.updateSettingAction.request
        let expectedResponse = profileDataModelMock.updateSettingAction.responseSuccess
        let getUserDataRequest = profileDataModelMock.getUserDataAction.request
        keychainServiceMock.setUserId("user id")
        sut.getUserData(request: getUserDataRequest)

        // When
        sut.updateSetting(request: request)

        // Then
        XCTAssertTrue(profilePresenterMock.didSucceedUpdateSettingCalled)
        XCTAssertEqual(profilePresenterMock.didSucceedUpdateSettingCounter, 1)
        XCTAssertEqual(profilePresenterMock.didSucceedUpdateSettingResponse, expectedResponse)
    }

    func testUpdateSetting_WhenCalledWithRequestAndUserWasFetchedOnFailure_ShouldCallPresenterDidFailUpdateSettingWithResponseFailure() {
        // Given
        let request = profileDataModelMock.updateSettingAction.request
        let expectedResponse = profileDataModelMock.updateSettingAction.responseFailure
        let getUserDataRequest = profileDataModelMock.getUserDataAction.request
        keychainServiceMock.setUserId("user id")
        sut.getUserData(request: getUserDataRequest)
        userRepositoryMock.myError = ProfileDataModelMock.myError

        // When
        sut.updateSetting(request: request)

        // Then
        XCTAssertTrue(profilePresenterMock.didFailUpdateSettingCalled)
        XCTAssertEqual(profilePresenterMock.didFailUpdateSettingCounter, 1)
        XCTAssertEqual(profilePresenterMock.didFailUpdateSettingResponse, expectedResponse)
    }
}
