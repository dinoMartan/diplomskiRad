 //
//  MyProjectsInteractor.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol MyProjectsInteractorProtocol {
}

class MyProjectsInteractor: MyProjectsInteractorProtocol {
    var presenter: MyProjectsPresenterProtocol?

    deinit {
        print("deinit \(self)")
    }
}

extension MyProjectsInteractor {
}
