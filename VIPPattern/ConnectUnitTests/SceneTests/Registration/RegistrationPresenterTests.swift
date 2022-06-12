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

    override func setUpWithError() throws {
        sut = RegistrationPresenter()
        registrationViewControllerMock = RegistrationViewControllerMock()
    }

    override func tearDownWithError() throws {
        sut = nil
        registrationViewControllerMock = nil
    }
}

extension RegistrationPresenterTests {
    func testWhenInteractorDidSuceedRegisterActionWithResponseCalled_ShouldCallViewControllerPresenterDidSucceedRegisterWith() {
        
    }
}
