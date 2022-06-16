//
//  LoginViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect

class LoginViewControllerMock: LoginPresenterOutput {
    var didSucceedLoginCalled = false
    var didSucceedLoginCounter = 0
    var didSucceedLoginViewModel: Login.LoginAction.ViewModel.Success?

    var didFailLoginCalled = false
    var didFailLoginCounter = 0
    var didFailLoginViewModel: Login.LoginAction.ViewModel.Failure?

    var didSucceedForgottenPasswordCalled = false
    var didSucceedForgottenPasswordCounter = 0
    var didSucceedForgottenPasswordViewModel: Login.ForgottenPasswordAction.ViewModel.Success?

    var didFailForgottenPasswordCalled = false
    var didFailForgottenPasswordCounter = 0
    var didFailForgottenPasswordViewModel: Login.ForgottenPasswordAction.ViewModel.Failure?
}

extension LoginViewControllerMock {
    func presenter(didSucceedLogin viewModel: Login.LoginAction.ViewModel.Success) {
        didSucceedLoginCalled = true
        didSucceedLoginCounter += 1
        didSucceedLoginViewModel = viewModel
    }

    func presenter(didFailLogin viewModel: Login.LoginAction.ViewModel.Failure) {
        didFailLoginCalled = true
        didFailLoginCounter += 1
        didFailLoginViewModel = viewModel
    }

    func presenter(didSucceedForgottenPassword viewModel: Login.ForgottenPasswordAction.ViewModel.Success) {
        didSucceedForgottenPasswordCalled = true
        didSucceedForgottenPasswordCounter += 1
        didSucceedForgottenPasswordViewModel = viewModel
    }

    func presenter(didFailForgottenPassword viewModel: Login.ForgottenPasswordAction.ViewModel.Failure) {
        didFailForgottenPasswordCalled = true
        didFailForgottenPasswordCounter += 1
        didFailForgottenPasswordViewModel = viewModel
    }
}
