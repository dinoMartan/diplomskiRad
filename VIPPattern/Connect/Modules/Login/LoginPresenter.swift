//
//  LoginPresenter.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func interactorDidSuceedLogin()
    func interactorDidSucceedSendForgottenPasswordEmail()
    func interactor(didFail myError: MyError)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var viewController: LoginPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactorDidSuceedLogin() {
        viewController?.presenterDidSucceedLogin()
    }

    func interactorDidSucceedSendForgottenPasswordEmail() {
        viewController?.presenter(didSucceedSendForgottenPasswordEmail: "Email poslan",
                                  message: "Email za reset lozinke je poslan na Vašu email adresu")
    }

    func interactor(didFail myError: MyError) {
        viewController?.presenter(didFail: myError)
    }
}
