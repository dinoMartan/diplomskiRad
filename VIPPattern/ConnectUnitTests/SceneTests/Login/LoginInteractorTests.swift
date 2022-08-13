//
//  LoginInteractorTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect
import XCTest

class LoginInteractorTests: XCTestCase {
    private var sut: LoginInteractor!
    private var loginPresenterMock: LoginPresenterMock!
    private var keychainServiceMock: KeychainServiceMock!
    private var authenticationRepositoryMock: AuthenticationRepositoryMock!
    private var loginDataModelMock: LoginDataModelMock!
    private var dataMock: DataMock!

    override func setUpWithError() throws {
        loginDataModelMock = LoginDataModelMock()
        keychainServiceMock = KeychainServiceMock()
        authenticationRepositoryMock = AuthenticationRepositoryMock()
        sut = LoginInteractor(keychainService: keychainServiceMock,
                              authenticationRepository: authenticationRepositoryMock)
        loginPresenterMock = LoginPresenterMock()
        sut.presenter = loginPresenterMock
        dataMock = DataMock()
    }

    override func tearDownWithError() throws {
        sut = nil
        loginPresenterMock = nil
        keychainServiceMock = nil
        authenticationRepositoryMock = nil
        loginDataModelMock = nil
        dataMock = nil
    }
}

// MARK: LoginUserAction tests
extension LoginInteractorTests {
    func testLoginUserAction_WhenCalledWithRequest_ShouldCallAuthenticationRepositorySignInUserWithRequestData() {
        // Given
        let request = loginDataModelMock.loginAction.request

        // When
        sut.loginUser(request: request)

        // Then
        XCTAssertTrue(authenticationRepositoryMock.signInUserCalled)
        XCTAssertEqual(authenticationRepositoryMock.signInUserCounter, 1)
        XCTAssertEqual(authenticationRepositoryMock.email, request.email)
        XCTAssertEqual(authenticationRepositoryMock.password, request.password)
    }

    func testLoginUserAction_WhenCalledWithRequestOnSuccess_ShouldCallKeychainServiceSetUserLoggedInWiithTrue() {
        // Given
        let request = loginDataModelMock.loginAction.request
        authenticationRepositoryMock.expectedResponse = dataMock.getAuthenticationResponse()

        // When
        sut.loginUser(request: request)

        // Then
        XCTAssertTrue(keychainServiceMock.getUserLoggedIn())
    }

    func testLoginUserAction_WhenCalledWithRequestOnSuccess_ShouldCallKeychainServiceSetUserIdWithUserIdFromResponse() {
        // Given
        let request = loginDataModelMock.loginAction.request
        let expectedUserId = dataMock.authenticationUserId
        authenticationRepositoryMock.expectedResponse = dataMock.getAuthenticationResponse()

        // When
        sut.loginUser(request: request)

        // Then
        XCTAssertEqual(expectedUserId, keychainServiceMock.getUserId())
    }

    func testLoginUserAction_WhenCalledWithRequestOnSuccess_ShouldCallPresenterDidSucceedLoginWithResponseSuccess() {
        // Given
        let request = loginDataModelMock.loginAction.request
        let expectedResponse = loginDataModelMock.loginAction.responseSuccess
        authenticationRepositoryMock.expectedResponse = dataMock.getAuthenticationResponse()

        // When
        sut.loginUser(request: request)

        // Then
        XCTAssertTrue(loginPresenterMock.didSucceedLoginCalled)
        XCTAssertEqual(loginPresenterMock.didSucceedLoginCounter, 1)
        XCTAssertEqual(loginPresenterMock.didSucceedLoginResponse, expectedResponse)
    }

    func testLoginUserAction_WhenCalledWithRequestOnError_ShouldCallPresenterDidFailLoginWithResponseFailure() {
        // Given
        let myError = LoginDataModelMock.myError
        authenticationRepositoryMock.myError = myError
        let request = loginDataModelMock.loginAction.request
        let expectedResponse = loginDataModelMock.loginAction.responseFailure

        // When
        sut.loginUser(request: request)

        // Then
        XCTAssertTrue(loginPresenterMock.didFailLoginCalled)
        XCTAssertEqual(loginPresenterMock.didFailLoginCounter, 1)
        XCTAssertEqual(loginPresenterMock.didFailLoginResponse, expectedResponse)
    }
}

// MARK: ForgottenPasswordAction tests
extension LoginInteractorTests {
    func testForgottenPasswordAction_WhenCalledWithRequest_ShouldCallAuthenticationRepositorySendResetPasswordEmailWithRequestData() {
        // Given
        let request = loginDataModelMock.forgottenPasswordAction.request

        // When
        sut.forgottenPassword(request: request)

        // Then
        XCTAssertTrue(authenticationRepositoryMock.sendResetPasswordEmailCalled)
        XCTAssertEqual(authenticationRepositoryMock.sendResetPasswordEmailCounter, 1)
        XCTAssertEqual(authenticationRepositoryMock.email, request.email)
    }

    func testForgottenPasswordAction_WhenCalledWithRequestOnSuccess_ShouldCallPresenterDidSucceedForgottenPasswordWithResponseSuccess() {
        // Given
        let request = loginDataModelMock.forgottenPasswordAction.request
        let expectedResponse = loginDataModelMock.forgottenPasswordAction.responseSuccess
        authenticationRepositoryMock.expectedResponse = Void()

        // When
        sut.forgottenPassword(request: request)

        // Then
        XCTAssertTrue(loginPresenterMock.didSucceedForgottenPasswordCalled)
        XCTAssertEqual(loginPresenterMock.didSucceedForgottenPasswordCounter, 1)
        XCTAssertEqual(loginPresenterMock.didSucceedForgottenPasswordResponse, expectedResponse)
    }

    func testForgottenPasswordAction_WhenCalledWithRequestOnError_ShouldCallPresenterDidFailForgottenPasswordWithResponseFailure() {
        // Given
        let myError = LoginDataModelMock.myError
        authenticationRepositoryMock.myError = myError
        let request = loginDataModelMock.forgottenPasswordAction.request
        let expectedResponse = loginDataModelMock.forgottenPasswordAction.responseFailure

        // When
        sut.forgottenPassword(request: request)

        // Then
        XCTAssertTrue(loginPresenterMock.didFailForgottenPasswordCalled)
        XCTAssertEqual(loginPresenterMock.didFailForgottenPasswordCounter, 1)
        XCTAssertEqual(loginPresenterMock.didFailForgottenPasswordResponse, expectedResponse)
    }
}
