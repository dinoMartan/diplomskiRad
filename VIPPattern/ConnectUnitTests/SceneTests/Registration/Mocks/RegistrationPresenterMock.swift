//
//  RegistrationPresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 03.06.2022..
//

@testable import Connect
import XCTest

class RegistrationPresenterMock: RegistrationPresenterProtocol {
    var didSucceedRegisterActionCalled = false
    var didSucceedRegisterActionCounter = 0
    var didSucceedRegisterActionResponse: Registration.RegisterAction.Response.Success?

    var didFailRegisterActionCalled = false
    var didFailRegisterActionCounter = 0
    var didFailRegisterActionResponse: Registration.RegisterAction.Response.Failure?
}

extension RegistrationPresenterMock {
    func interactor(didSuceedRegisterAction response: Registration.RegisterAction.Response.Success) {
        didSucceedRegisterActionCalled = true
        didSucceedRegisterActionCounter += 1
        didSucceedRegisterActionResponse = response
    }

    func interactor(didFailRegisterAction response: Registration.RegisterAction.Response.Failure) {
        didFailRegisterActionCalled = true
        didFailRegisterActionCounter += 1
        didFailRegisterActionResponse = response
    }
}
