 //
//  ProfilePresenterTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect
import XCTest

class ProfilePresenterTests: XCTestCase {
    private var sut: ProfilePresenter!
    private var profileViewControllerMock: ProfileViewControllerMock!
    private var profileDataModelMock: ProfileDataModelMock!

    override func setUpWithError() throws {
        profileDataModelMock = ProfileDataModelMock()
        profileViewControllerMock = ProfileViewControllerMock()
        sut = ProfilePresenter()
        sut.viewController = profileViewControllerMock
    }

    override func tearDownWithError() throws {
        profileDataModelMock = nil
        profileViewControllerMock = nil
        sut = nil
    }
}

// MARK: GetUserDataAction tests
extension ProfilePresenterTests {
    func testDidSucceedGetUserData_WhenCalledWithResponse_ShouldCallViewControllerDidSucceedGetUserDataWithViewModelSuccess() {
        // Given
        let response = profileDataModelMock.getUserDataAction.responseSuccess
        let expectedViewModel = profileDataModelMock.getUserDataAction.viewModelSuccess

        // When
        sut.interactor(didSucceedGetUserData: response)

        // Then
        XCTAssertTrue(profileViewControllerMock.didSucceedGetUserDataCalled)
        XCTAssertEqual(profileViewControllerMock.didSucceedGetUserDataCounter, 1)
        XCTAssertEqual(profileViewControllerMock.didSucceedGetUserDataViewModel, expectedViewModel)
    }

    func testDidFailGetUserData_WhenCalledWithResponse_ShouldCallViewControllerDidFailGetUserDataWithViewModelFailure() {
        // Given
        let response = profileDataModelMock.getUserDataAction.responseFailure
        let expectedViewModel = profileDataModelMock.getUserDataAction.viewModelFailure

        // When
        sut.interactor(didFailGetUserData: response)

        // Then
        XCTAssertTrue(profileViewControllerMock.didFailGetUserDataCalled)
        XCTAssertEqual(profileViewControllerMock.didFailGetUserDataCounter, 1)
        XCTAssertEqual(profileViewControllerMock.didFailGetUserDataViewModel, expectedViewModel)
    }
}

// MARK: UpdateSettingAction tests
extension ProfilePresenterTests {
    func testDidSucceedUpdateSetting_WhenCalledWithResponse_ShouldCallViewControllerDidSucceedUpdateSettingWithViewModelSuccess() {
        // Given
        let response = profileDataModelMock.updateSettingAction.responseSuccess
        let expectedViewModel = profileDataModelMock.updateSettingAction.viewModelSuccess

        // When
        sut.interactor(didSucceedUpdateSetting: response)

        // Then
        XCTAssertTrue(profileViewControllerMock.didSucceedUpdateSettingCalled)
        XCTAssertEqual(profileViewControllerMock.didSucceedUpdateSettingCounter, 1)
        XCTAssertEqual(profileViewControllerMock.didSucceedUpdateSettingViewModel, expectedViewModel)
    }

    func testDidFailUpdateSetting_WhenCalledWithResponse_ShouldCallViewControllerDidFailUpdateSettingWithViewModelFailure() {
        // Given
        let response = profileDataModelMock.updateSettingAction.responseFailure
        let expectedViewModel = profileDataModelMock.updateSettingAction.viewModelFailure

        // When
        sut.interactor(didFailUpdateSetting: response)

        // Then
        XCTAssertTrue(profileViewControllerMock.didFailUpdateSettingCalled)
        XCTAssertEqual(profileViewControllerMock.didFailUpdateSettingCounter, 1)
        XCTAssertEqual(profileViewControllerMock.didFailUpdateSettingViewModel, expectedViewModel)
    }
}

// MARK: SignOutAction tests
extension ProfilePresenterTests {
    func testDidSucceedSignOut_WhenCalledWithResponse_ShouldCallViewControllerDidSucceedSignOutWithViewModelSuccess() {
        // Given
        let response = profileDataModelMock.signOutAction.responseSuccess
        let expectedViewModel = profileDataModelMock.signOutAction.viewModelSuccess

        // When
        sut.interactor(didSucceedSignOut: response)

        // Then
        XCTAssertTrue(profileViewControllerMock.didSucceedSignOutCalled)
        XCTAssertEqual(profileViewControllerMock.didSucceedSignOutCounter, 1)
        XCTAssertEqual(profileViewControllerMock.didSucceedSignOutViewModel, expectedViewModel)
    }

    func testDidFailSignOut_WhenCalledWithResponse_ShouldCallViewControllerDidFailSignOutWithViewModelFailure() {
        // Given
        let response = profileDataModelMock.signOutAction.responseFailure
        let expectedViewModel = profileDataModelMock.signOutAction.viewModelFailure

        // When
        sut.interactor(didFailSignOut: response)

        // Then
        XCTAssertTrue(profileViewControllerMock.didFailSignOutCalled)
        XCTAssertEqual(profileViewControllerMock.didFailSignOutCounter, 1)
        XCTAssertEqual(profileViewControllerMock.didFailSignOutViewModel, expectedViewModel)
    }
}
