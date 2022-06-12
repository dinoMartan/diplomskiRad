//
//  LoginPresenter.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func interactor(didSucceedLogin response: Login.LoginAction.Response.Success)
    func interactor(didFailLogin response: Login.LoginAction.Response.Failure)
    func interactor(didSucceedForgottenPassword response: Login.ForgottenPasswordAction.Response.Success)
    func interactor(didFailForgottenPassword response: Login.ForgottenPasswordAction.Response.Failure)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var viewController: LoginPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedLogin response: Login.LoginAction.Response.Success) {
        viewController?.presenter(didSucceedLogin: Login.LoginAction.ViewModel.Success())
    }

    func interactor(didSucceedForgottenPassword response: Login.ForgottenPasswordAction.Response.Success) {
        let title = "Email poslan"
        let message = "Email za reset lozinke je poslan na Vašu email adresu"
        viewController?.presenter(didSucceedForgottenPassword: Login.ForgottenPasswordAction.ViewModel.Success(title: title,
                                                                                                               message: message))
    }

    func interactor(didFailLogin response: Login.LoginAction.Response.Failure) {
        viewController?.presenter(didFailLogin: Login.LoginAction.ViewModel.Failure(myError: response.myError))
    }

    func interactor(didFailForgottenPassword response: Login.ForgottenPasswordAction.Response.Failure) {
        viewController?.presenter(didFailForgottenPassword: Login.ForgottenPasswordAction.ViewModel.Failure(myError: response.myError))
    }
}
