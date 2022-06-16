//
//  RegistrationViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.06.2022..
//

@testable import Connect

class RegistrationViewControllerMock: RegistrationPresenterOutput {
    var presenterDidSucceedRegisterCalled = false
    var presenterDidSucceedRegisterCounter = 0
    var presenterDidSucceedRegisterViewModel: Registration.RegisterAction.ViewModel.Success?

    var presenterDidFailRegisterCalled = false
    var presenterDidFailRegisterCounter = 0
    var presenterDidFailRegisterViewModel: Registration.RegisterAction.ViewModel.Failure?
}

extension RegistrationViewControllerMock {
    func presenter(didSucceedRegister viewModel: Registration.RegisterAction.ViewModel.Success) {
        presenterDidSucceedRegisterCalled = true
        presenterDidSucceedRegisterCounter += 1
        presenterDidSucceedRegisterViewModel = viewModel
    }
    
    func presenter(didFailRegister viewModel: Registration.RegisterAction.ViewModel.Failure) {
        presenterDidFailRegisterCalled = true
        presenterDidFailRegisterCounter += 1
        presenterDidFailRegisterViewModel = viewModel
    }
}
