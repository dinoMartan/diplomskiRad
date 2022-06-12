//
//  RegistrationDataModelMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 30.05.2022..
//

@testable import Connect

struct RegistrationDataModelMock {
    static let myError = MyError(type: .codableError,
                                         message: "This is message")

    let registerAction = RegisterAction()
}

// MARK: Register Action
extension RegistrationDataModelMock {
    struct RegisterAction {
        let request = Registration.RegisterAction.Request(username: "username",
                                                          firstName: "first name",
                                                          lastName: "last name",
                                                          email: "email@email.com",
                                                          password: "123456",
                                                          image: nil)

        let responseSuccess = Registration.RegisterAction.Response.Success()
        let responseFailure = Registration.RegisterAction.Response.Failure(myError: RegistrationDataModelMock.myError)

        let viewModelSuccess = Registration.RegisterAction.ViewModel.Success()
        let viewModelFailure = Registration.RegisterAction.ViewModel.Failure(myError: RegistrationDataModelMock.myError)

    }
}
