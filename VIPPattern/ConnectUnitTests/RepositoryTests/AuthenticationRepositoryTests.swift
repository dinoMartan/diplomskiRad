//
//  AuthenticationRepositoryTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.08.2022..
//

import FirebaseAuth
@testable import Connect
import Foundation
import XCTest

class AuthenticationRepositoryTests: XCTestCase {
    private var sut: AuthenticationRepository!
    private var authenticationServiceMock: AuthenticationServiceMock!
    private var dataMock: DataMock!

    override func setUpWithError() throws {
        authenticationServiceMock = AuthenticationServiceMock()
        sut = AuthenticationRepository(authenticationService: authenticationServiceMock)
        dataMock = DataMock()
    }

    override func tearDownWithError() throws {
        authenticationServiceMock = nil
        sut = nil
        dataMock = nil
    }
}

// MARK: registerUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) tests
extension AuthenticationRepositoryTests {
    func testRegisterUser_WhenCalledWithEmailAndPassword_ShouldCallAuthenticationServiceRegisterUserWithEmailAndPassword() {
        // Given
        let email = "email@email.com"
        let password = "password"

        // When
        sut.registerUser(email: email, password: password) { _ in
            //
        }

        // Then
        XCTAssertTrue(authenticationServiceMock.registerUserCalled)
        XCTAssertEqual(authenticationServiceMock.registerUserCounter, 1)
        XCTAssertEqual(authenticationServiceMock.registerUserEmail, email)
        XCTAssertEqual(authenticationServiceMock.registerUserPassword, password)
    }

    func testRegisterUser_WhenCalledWithEmailAndPasswordOnSuccess_ShouldCallCompletionWithAuthenticationResponse() {
        // Given
        let expectation = expectation(description: "expectation")
        let email = "email@email.com"
        let password = "password"
        let expectedAuthenticationResponse = dataMock.getAuthenticationResponse()
        authenticationServiceMock.expectedResponse = expectedAuthenticationResponse

        // When
        sut.registerUser(email: email, password: password) { result in
            guard case .success(let authenticationResponse) = result,
                  expectedAuthenticationResponse == authenticationResponse
            else {
                return
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }

    func testRegisterUser_WhenCalledWithEmailAndPasswordOnFailure_ShouldCallCompletionWithMyError() {
        // Given
        let expectation = expectation(description: "expectation")
        let email = "email@email.com"
        let password = "password"
        let myError = MyError(type: .registrationFailed, message: nil)
        authenticationServiceMock.myError = myError

        // When
        sut.registerUser(email: email, password: password) { result in
            guard case .failure(let error) = result,
                  myError == error
            else {
                return
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }
}

// MARK: signInUser(email: String, password: String, completion: @escaping ((Result<AuthenticationResponse, MyError>) -> Void)) tests
extension AuthenticationRepositoryTests {
    func testSignInUser_WhenCalledWithEmailAndPassword_ShouldCallAuthenticationServiceSignInUserWithEmailAndPassword() {
        // Given
        let email = "email@email.com"
        let password = "password"

        // When
        sut.signInUser(email: email, password: password) { _ in
            //
        }

        // Then
        XCTAssertTrue(authenticationServiceMock.signInUserCalled)
        XCTAssertEqual(authenticationServiceMock.signInUserCounter, 1)
        XCTAssertEqual(authenticationServiceMock.signInUserEmail, email)
        XCTAssertEqual(authenticationServiceMock.signInUserPassword, password)
    }

    func testSignInUser_WhenCalledWithEmailAndPasswordOnSuccess_ShouldCallCompletionWithAuthenticationResponse() {
        // Given
        let expectation = expectation(description: "expectation")
        let email = "email@email.com"
        let password = "password"
        let expectedAuthenticationResponse = dataMock.getAuthenticationResponse()
        authenticationServiceMock.expectedResponse = expectedAuthenticationResponse

        // When
        sut.signInUser(email: email, password: password) { result in
            guard case .success(let authenticationResponse) = result,
                  expectedAuthenticationResponse == authenticationResponse
            else {
                return
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }

    func testSignInUser_WhenCalledWithEmailAndPasswordOnFailure_ShouldCallCompletionWithMyError() {
        // Given
        let expectation = expectation(description: "expectation")
        let email = "email@email.com"
        let password = "password"
        let myError = MyError(type: .signInFailed, message: nil)
        authenticationServiceMock.myError = myError

        // When
        sut.signInUser(email: email, password: password) { result in
            guard case .failure(let error) = result,
                  myError == error
            else {
                return
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }
}

// MARK: sendResetPasswordEmail(email: String, completion: @escaping ((Result<Void, MyError>) -> Void)) tests
extension AuthenticationRepositoryTests {
    func testSendResetPasswordEmail_WhenCalledWithEmail_ShouldCallAuthenticationServiceSignInUserWithEmailAndPassword() {
        // Given
        let email = "email@email.com"

        // When
        sut.sendResetPasswordEmail(email: email) { _ in
            //
        }

        // Then
        XCTAssertTrue(authenticationServiceMock.sendResetPasswordEmailCalled)
        XCTAssertEqual(authenticationServiceMock.sendResetPasswordEmailCounter, 1)
        XCTAssertEqual(authenticationServiceMock.sendResetPasswordEmailEmail, email)
    }

    func testSendResetPasswordEmail_WhenCalledWithEmailOnSuccess_ShouldCallCompletion() {
        // Given
        let expectation = expectation(description: "expectation")
        let email = "email@email.com"
        authenticationServiceMock.expectedResponse = Void()

        // When
        sut.sendResetPasswordEmail(email: email) { result in
            guard case .success(_) = result else {
                return
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }

    func testSendResetPasswordEmail_WhenCalledWithEmailOnFailure_ShouldCallCompletionWithMyError() {
        // Given
        let expectation = expectation(description: "expectation")
        let email = "email@email.com"
        let myError = MyError(type: .passwordResetFailed, message: nil)
        authenticationServiceMock.myError = myError

        // When
        sut.sendResetPasswordEmail(email: email) { result in
            guard case .failure(let error) = result,
                  myError == error
            else {
                return
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }
}
