//
//  LoginPresenter.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func interactor(didSucceedLogin response: Login.LoginAction.ResponseSuccess)
    func interactor(didSucceedForgottenPassword response: Login.ForgottenPasswordAction.ResponseSuccess)
    func interactor(didFail response: Login.ResponseFailure)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var viewController: LoginPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedLogin response: Login.LoginAction.ResponseSuccess) {
        viewController?.presenter(didSucceedLogin: Login.LoginAction.ViewModelSuccess())
    }

    func interactor(didSucceedForgottenPassword response: Login.ForgottenPasswordAction.ResponseSuccess) {
        let title = "Email poslan"
        let message = "Email za reset lozinke je poslan na Vašu email adresu"
        viewController?.presenter(didSucceedForgottenPassword: Login.ForgottenPasswordAction.ViewModelSuccess(title: title,
                                                                                                              message: message))
    }

    func interactor(didFail response: Login.ResponseFailure) {
        viewController?.presenter(didFail: Login.ViewModelFailure(myError: response.myError))
    }
}
