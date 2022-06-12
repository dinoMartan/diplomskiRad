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
    let responseFailure = Registration.ResponseFailure(myError: myError)
    let viewModelFailure = Registration.ViewModelFailure(myError: myError)
    let registerAction = RegisterAction()

    struct RegisterAction {
        let request = Registration.RegisterAction.Request(username: "username",
                                                          firstName: "first name",
                                                          lastName: "last name",
                                                          email: "email@email.com",
                                                          password: "123456",
                                                          image: nil)
        let responseSuccess = Registration.RegisterAction.ResponseSuccess()
        let viewModelSuccess = Registration.RegisterAction.ViewModelSuccess()
    }
}
