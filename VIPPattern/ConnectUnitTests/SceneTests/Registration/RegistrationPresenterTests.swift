//
//  RegistrationPresenterTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.06.2022..
//

@testable import Connect
import XCTest

class RegistrationPresenterTests: XCTestCase {
    private var sut: RegistrationPresenter!
    private var registrationViewControllerMock: RegistrationViewControllerMock!
    private var registrationDataModelMock: RegistrationDataModelMock!

    override func setUpWithError() throws {
        sut = RegistrationPresenter()
        registrationViewControllerMock = RegistrationViewControllerMock()
        registrationDataModelMock = RegistrationDataModelMock()
        sut.viewController = registrationViewControllerMock
    }

    override func tearDownWithError() throws {
        sut = nil
        registrationViewControllerMock = nil
        registrationDataModelMock = nil
    }
}

extension RegistrationPresenterTests {
    func testWhenInteractorDidSucceedRegisterActionWithResponseCalled_ShouldCallViewControllerPresenterDidSucceedRegisterWithRegisterActionViewModelSuccess() {
        // Given
        let response = registrationDataModelMock.registerAction.responseSuccess
        let expectedViewModel = registrationDataModelMock.registerAction.viewModelSuccess

        // When
        sut.interactor(didSuceedRegisterAction: response)

        // Then
        XCTAssertTrue(registrationViewControllerMock.presenterDidSucceedRegisterCalled)
        XCTAssertEqual(registrationViewControllerMock.presenterDidSucceedRegisterCounter, 1)
        XCTAssertEqual(registrationViewControllerMock.presenterDidSucceedRegisterViewModel, expectedViewModel)
    }

    func testWhenInteractorDidFailRegisterActionWithResponseCalled_ShouldCallViewControllerPresenterDidFailRegisterWithRegisterActionViewModelFailure() {
        // Given
        let response = registrationDataModelMock.registerAction.responseFailure
        let expectedViewModel = registrationDataModelMock.registerAction.viewModelFailure

        // When
        sut.interactor(didFailRegisterAction: response)

        // Then
        XCTAssertTrue(registrationViewControllerMock.presenterDidFailRegisterCalled)
        XCTAssertEqual(registrationViewControllerMock.presenterDidFailRegisterCounter, 1)
        XCTAssertEqual(registrationViewControllerMock.presenterDidFailRegisterViewModel, expectedViewModel)
    }
}
