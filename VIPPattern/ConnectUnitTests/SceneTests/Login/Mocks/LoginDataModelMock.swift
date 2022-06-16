//
//  LoginDataModelMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect

struct LoginDataModelMock {
    static let myError = MyError(type: .codableError,
                                         message: "This is message")
    let loginAction = LoginDataModelMock.LoginAction()
    let forgottenPasswordAction = LoginDataModelMock.ForgottenPasswordAction()
}

extension LoginDataModelMock {
    struct LoginAction {
        let request = Login.LoginAction.Request(email: "email@email.com", password: "123456")
        let responseSuccess = Login.LoginAction.Response.Success()
        let responseFailure = Login.LoginAction.Response.Failure(myError: LoginDataModelMock.myError)
        let viewModelSuccess = Login.LoginAction.ViewModel.Success()
        let viewModelFailure = Login.LoginAction.ViewModel.Failure(myError: LoginDataModelMock.myError)
    }
}

extension LoginDataModelMock {
    struct ForgottenPasswordAction {
        let request = Login.ForgottenPasswordAction.Request(email: "email@email.com")
        let responseSuccess = Login.ForgottenPasswordAction.Response.Success()
        let responseFailure = Login.ForgottenPasswordAction.Response.Failure(myError: LoginDataModelMock.myError)
        let viewModelSuccess = Login.ForgottenPasswordAction.ViewModel.Success(title: "Email poslan",
                                                                               message: "Email za reset lozinke je poslan na Vašu email adresu")
        let viewModelFailure = Login.ForgottenPasswordAction.ViewModel.Failure(myError: LoginDataModelMock.myError)
    }
}
