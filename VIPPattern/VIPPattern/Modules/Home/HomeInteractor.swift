 //
//  HomeInteractor.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol HomeInteractorProtocol {
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?

    deinit {
        print("deinit \(self)")
    }
}

extension HomeInteractor {
}
