//
//  RegistrationConfigurator.swift
//  VIPPattern
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

class RegistrationConfigurator {
    static func configureModule(registrationRouterOutput: RegistrationRouterOutput,
                                viewController: RegistrationViewController,
                                keychainService: KeychainServiceProtocol,
                                authenticationService: AuthenticationServiceProtocol) {
        let view = RegistrationView()
        let router = RegistrationRouter()
        let interactor = RegistrationInteractor(keychainService: keychainService,
                                                authenticationService: authenticationService)
        let presenter = RegistrationPresenter()

        viewController.registrationView = view
        viewController.router = router
        viewController.interactor = interactor

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.registrationRouterOutput = registrationRouterOutput
    }
}
