 //
//  MyProjectsPresenter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol MyProjectsPresenterProtocol: AnyObject {
}

class MyProjectsPresenter: MyProjectsPresenterProtocol {
    weak var viewController: MyProjectsPresenterOutput?

    deinit {
        print("deinit \(self)")
    }
}
