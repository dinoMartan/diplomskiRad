//
//  RegistrationInteractorTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

@testable import Connect
import XCTest

class RegistrationInteractorTests: XCTestCase {
    private var sut: RegistrationInteractor!
    private var registrationPresenterMock: RegistrationPresenterMock!
    private var keychainServiceMock: KeychainServiceMock!
    private var authenticationRepositoryMock: AuthenticationRepositoryMock!
    private var userRepositoryMock: UserRepositoryMock!
    private var registrationDataModelMock: RegistrationDataModelMock!

    override func setUpWithError() throws {
        registrationDataModelMock = RegistrationDataModelMock()
        registrationPresenterMock = RegistrationPresenterMock()
        keychainServiceMock = KeychainServiceMock()
        authenticationRepositoryMock = AuthenticationRepositoryMock()
        userRepositoryMock = UserRepositoryMock()
        sut = RegistrationInteractor(keychainService: keychainServiceMock,
                                     authenticationRepository: authenticationRepositoryMock,
                                     userRepository: userRepositoryMock)
        sut.presenter = registrationPresenterMock
    }

    override func tearDownWithError() throws {
        registrationDataModelMock = nil
        keychainServiceMock = nil
        authenticationRepositoryMock = nil
        userRepositoryMock = nil
        sut = nil
        registrationPresenterMock = nil
    }
}

extension RegistrationInteractorTests {
    func testRegisterUser_WhenRegisterUserCalledWithRequest_ShouldCallAuthenticationRepository() {
        // Given
        let request = registrationDataModelMock.registerAction.request

        // When
        sut.registerUser(request: request)

        // Then
        XCTAssertTrue(authenticationRepositoryMock.registerUserCalled)
        XCTAssertEqual(authenticationRepositoryMock.registerUserCounter, 1)
        XCTAssertEqual(authenticationRepositoryMock.email, request.email)
        XCTAssertEqual(authenticationRepositoryMock.password, request.password)
    }

    func testRegisterUser_WhenRegisterUserCalledWithRequestOnSuccess_ShouldCallPresenterWithResponseSucess() {
        // Given
        let request = registrationDataModelMock.registerAction.request
        let expectedResponse = registrationDataModelMock.registerAction.responseSuccess

        // When
        sut.registerUser(request: request)

        // Then
        XCTAssertTrue(registrationPresenterMock.didSuceedRegisterActionCalled)
        XCTAssertEqual(registrationPresenterMock.didSuceedRegisterActionCounter, 1)
        XCTAssertEqual(registrationPresenterMock.didSuceedRegisterActionResponse, expectedResponse)
    }

    func testRegisterUser_WhenRegisterUserCalledWithRequestOnFailure_ShouldCallPresenterWithResponseFailure() {
        // Given
        let myError = RegistrationDataModelMock.myError
        let request = registrationDataModelMock.registerAction.request
        let expectedResponse = registrationDataModelMock.responseFailure
        authenticationRepositoryMock.myError = myError

        // When
        sut.registerUser(request: request)

        // Then
        XCTAssertTrue(registrationPresenterMock.didFailCalled)
        XCTAssertEqual(registrationPresenterMock.didFailCounter, 1)
        XCTAssertEqual(registrationPresenterMock.didFailResponse, expectedResponse)
    }
}
