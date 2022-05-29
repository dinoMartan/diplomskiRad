//
//  RegistrationPresenter.swift
//  Connect
//
//  Created by Dino Martan on 24.05.2022..
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func interactorDidSucceedRegistration()
    func interactor(didFail myError: MyError)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var viewController: RegistrationPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactorDidSucceedRegistration() {
        viewController?.presenterDidSucceedRegistration()
    }

    func interactor(didFail myError: MyError) {
        viewController?.presenter(didFail: myError)
    }
}
