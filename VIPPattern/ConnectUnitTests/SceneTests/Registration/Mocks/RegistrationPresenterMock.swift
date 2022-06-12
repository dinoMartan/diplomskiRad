//
//  RegistrationPresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 03.06.2022..
//

@testable import Connect
import XCTest

class RegistrationPresenterMock: RegistrationPresenterProtocol {
    var didSuceedRegisterActionCalled = false
    var didSuceedRegisterActionCounter = 0
    var didSuceedRegisterActionResponse: Registration.RegisterAction.ResponseSuccess?

    var didFailCalled = false
    var didFailCounter = 0
    var didFailResponse: Registration.ResponseFailure?
}

extension RegistrationPresenterMock {
    func interactor(didSuceedRegisterAction response: Registration.RegisterAction.ResponseSuccess) {
        didSuceedRegisterActionCalled = true
        didSuceedRegisterActionCounter += 1
        didSuceedRegisterActionResponse = response
    }

    func interactor(didFail response: Registration.ResponseFailure) {
        didFailCalled = true
        didFailCounter += 1
        didFailResponse = response
    }
}
