//
//  LoginPresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect

class LoginPresenterMock: LoginPresenterProtocol {
    var didSucceedLoginCalled = false
    var didSucceedLoginCounter = 0
    var didSucceedLoginResponse: Login.LoginAction.Response.Success?

    var didFailLoginCalled = false
    var didFailLoginCounter = 0
    var didFailLoginResponse: Login.LoginAction.Response.Failure?

    var didSucceedForgottenPasswordCalled = false
    var didSucceedForgottenPasswordCounter = 0
    var didSucceedForgottenPasswordResponse: Login.ForgottenPasswordAction.Response.Success?

    var didFailForgottenPasswordCalled = false
    var didFailForgottenPasswordCounter = 0
    var didFailForgottenPasswordResponse: Login.ForgottenPasswordAction.Response.Failure?
}

extension LoginPresenterMock {
    func interactor(didSucceedLogin response: Login.LoginAction.Response.Success) {
        didSucceedLoginCalled = true
        didSucceedLoginCounter += 1
        didSucceedLoginResponse = response
    }

    func interactor(didFailLogin response: Login.LoginAction.Response.Failure) {
        didFailLoginCalled = true
        didFailLoginCounter += 1
        didFailLoginResponse = response
    }

    func interactor(didSucceedForgottenPassword response: Login.ForgottenPasswordAction.Response.Success) {
        didSucceedForgottenPasswordCalled = true
        didSucceedForgottenPasswordCounter += 1
        didSucceedForgottenPasswordResponse = response
    }

    func interactor(didFailForgottenPassword response: Login.ForgottenPasswordAction.Response.Failure) {
        didFailForgottenPasswordCalled = true
        didFailForgottenPasswordCounter += 1
        didFailForgottenPasswordResponse = response
    }
}
