//
//  LoginPresenterTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect
import XCTest

class LoginPresenterTests: XCTestCase {
    private var sut: LoginPresenter!
    private var loginViewControllerMock: LoginViewControllerMock!
    private var loginDataModelMock: LoginDataModelMock!

    override func setUpWithError() throws {
        loginDataModelMock = LoginDataModelMock()
        loginViewControllerMock = LoginViewControllerMock()
        sut = LoginPresenter()
        sut.viewController = loginViewControllerMock
    }

    override func tearDownWithError() throws {
        loginDataModelMock = nil
        loginViewControllerMock = nil
        sut = nil
    }
}

// MARK: LoginAction tests
extension LoginPresenterTests {
    func testDidSucceedLogin_WhenCalledWithResponseSuccess_ShouldCallViewControllerDidSucceedLoginWithViewModelSuccess() {
        // Given
        let response = loginDataModelMock.loginAction.responseSuccess
        let expectedViewModel = loginDataModelMock.loginAction.viewModelSuccess

        // When
        sut.interactor(didSucceedLogin: response)

        // Then
        XCTAssertTrue(loginViewControllerMock.didSucceedLoginCalled)
        XCTAssertEqual(loginViewControllerMock.didSucceedLoginCounter, 1)
        XCTAssertEqual(loginViewControllerMock.didSucceedLoginViewModel, expectedViewModel)
    }

    func testDidFailLogin_WhenCalledWithResponseFailure_ShouldCallViewControllerDidFailLoginWithViewModelFailure() {
        // Given
        let response = loginDataModelMock.loginAction.responseFailure
        let expectedViewModel = loginDataModelMock.loginAction.viewModelFailure

        // When
        sut.interactor(didFailLogin: response)

        // Then
        XCTAssertTrue(loginViewControllerMock.didFailLoginCalled)
        XCTAssertEqual(loginViewControllerMock.didFailLoginCounter, 1)
        XCTAssertEqual(loginViewControllerMock.didFailLoginViewModel, expectedViewModel)
    }
}

// MARK: ForgottenPasswordAction tests
extension LoginPresenterTests {
    func testDidSucceedForgottenPassword_WhenCalledWithResponseSuccess_ShouldCallViewControllerDidSucceedForgottenPasswordWithViewModelSuccess() {
        // Given
        let response = loginDataModelMock.forgottenPasswordAction.responseSuccess
        let expectedViewModel = loginDataModelMock.forgottenPasswordAction.viewModelSuccess

        // When
        sut.interactor(didSucceedForgottenPassword: response)

        // Then
        XCTAssertTrue(loginViewControllerMock.didSucceedForgottenPasswordCalled)
        XCTAssertEqual(loginViewControllerMock.didSucceedForgottenPasswordCounter, 1)
        XCTAssertEqual(loginViewControllerMock.didSucceedForgottenPasswordViewModel, expectedViewModel)
    }

    func testDidFailForgottenPassword_WhenCalledWithResponseFailure_ShouldCallViewControllerDidFailForgottenPasswordWithViewModelFailure() {
        // Given
        let response = loginDataModelMock.forgottenPasswordAction.responseFailure
        let expectedViewModel = loginDataModelMock.forgottenPasswordAction.viewModelFailure

        // When
        sut.interactor(didFailForgottenPassword: response)

        // Then
        XCTAssertTrue(loginViewControllerMock.didFailForgottenPasswordCalled)
        XCTAssertEqual(loginViewControllerMock.didFailForgottenPasswordCounter, 1)
        XCTAssertEqual(loginViewControllerMock.didFailForgottenPasswordViewModel, expectedViewModel)
    }
}
