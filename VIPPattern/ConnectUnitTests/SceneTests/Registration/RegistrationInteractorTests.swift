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
    private var keychainServiceMock: KeychainServiceMock!
    private var authenticationRepositoryMock: AuthenticationRepositoryMock!
    private var userRepositoryMock: UserRepositoryMock!
    private var dataModelMock: RegistrationDataModelMock!

    override func setUpWithError() throws {
        keychainServiceMock = KeychainServiceMock()
        authenticationRepositoryMock = AuthenticationRepositoryMock()
        userRepositoryMock = UserRepositoryMock()
        sut = RegistrationInteractor(keychainService: keychainServiceMock,
                                     authenticationRepository: authenticationRepositoryMock,
                                     userRepository: userRepositoryMock)
        dataModelMock = RegistrationDataModelMock()
    }

    override func tearDownWithError() throws {
        keychainServiceMock = nil
        authenticationRepositoryMock = nil
        userRepositoryMock = nil
        sut = nil
        dataModelMock = nil
    }
}

extension RegistrationInteractorTests {
    func testRegisterAction_WhenRequest_ShouldSomething() {
        // Given
        let request = dataModelMock.registerAction.request
        sut.registerUser(request: request)
    }
}
