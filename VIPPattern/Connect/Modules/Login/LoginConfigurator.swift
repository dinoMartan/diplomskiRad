//
//  LoginConfigurator.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

class LoginConfigurator {
    static func configureModule(loginRouterOutput: LoginRouterOutput,
                                viewController: LoginViewController,
                                keychainService: KeychainServiceProtocol,
                                authenticationService: AuthenticationServiceProtocol) {
        let view = LoginView()
        let router = LoginRouter()
        let interactor = LoginInteractor(keychainService: keychainService,
                                         authenticationService: authenticationService)
        let presenter = LoginPresenter()

        viewController.loginView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.loginRouterOutput = loginRouterOutput
    }
}
