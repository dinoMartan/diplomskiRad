//
//  RegistrationPresenter.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func interactor(didSuceedRegisterAction response: Registration.RegisterAction.ResponseSuccess)
    func interactor(didFail response: Registration.ResponseFailure)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var viewController: RegistrationPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSuceedRegisterAction response: Registration.RegisterAction.ResponseSuccess) {
        viewController?.presenter(didSucceedRegister: Registration.RegisterAction.ResponseSuccess())
    }

    func interactor(didFail response: Registration.ResponseFailure) {
        viewController?.presenter(didFail: Registration.ViewModelFailure(myError: response.myError))
    }
}
