 //
//  HomePresenter.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
}

class HomePresenter: HomePresenterProtocol {
    weak var viewController: HomePresenterOutput?

    deinit {
        print("deinit \(self)")
    }
}
