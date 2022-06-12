//
//  RegistrationViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.06.2022..
//

@testable import Connect

class RegistrationViewControllerMock: RegistrationPresenterOutput {
    var presenterDidSucceedRegisterCalled = false
    var presenterdidSucceedRegisterCounter = 0
    var presenterDidSucceedRegisterViewModel: Registration.RegisterAction.ResponseSuccess?

    var presenterDidFailCalled = false
    var presenterDidFailCounter = 0
    var presenterDidFailViewModel: Registration.ViewModelFailure?
}

extension RegistrationViewControllerMock {
    func presenter(didSucceedRegister viewModel: Registration.RegisterAction.ResponseSuccess) {
        presenterDidSucceedRegisterCalled = true
        presenterdidSucceedRegisterCounter += 1
        presenterDidSucceedRegisterViewModel = viewModel
    }
    
    func presenter(didFail viewModel: Registration.ViewModelFailure) {
        presenterDidFailCalled = true
        presenterDidFailCounter += 1
        presenterDidFailViewModel = viewModel
    }
}
