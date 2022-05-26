 //
//  ProfilePresenter.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var viewController: ProfilePresenterOutput?

    deinit {
        print("deinit \(self)")
    }
}
