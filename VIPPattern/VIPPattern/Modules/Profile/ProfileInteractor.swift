 //
//  ProfileInteractor.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import Foundation

protocol ProfileInteractorProtocol {
}

class ProfileInteractor: ProfileInteractorProtocol {
    var presenter: ProfilePresenterProtocol?

    deinit {
        print("deinit \(self)")
    }
}

extension ProfileInteractor {
}
