//
//  RegistrationPresenter.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func interactor(didSuceedRegisterAction response: Registration.RegisterAction.Response.Success)
    func interactor(didFailRegisterAction response: Registration.RegisterAction.Response.Failure)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var viewController: RegistrationPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSuceedRegisterAction response: Registration.RegisterAction.Response.Success) {
        viewController?.presenter(didSucceedRegister: Registration.RegisterAction.ViewModel.Success())
    }

    func interactor(didFailRegisterAction response: Registration.RegisterAction.Response.Failure) {
        viewController?.presenter(didFailRegister: Registration.RegisterAction.ViewModel.Failure(myError: response.myError))
    }
}
