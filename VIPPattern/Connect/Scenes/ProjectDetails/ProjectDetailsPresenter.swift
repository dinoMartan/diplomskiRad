 //
//  ProjectDetailsPresenter.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

protocol ProjectDetailsPresenterProtocol: AnyObject {
}

class ProjectDetailsPresenter: ProjectDetailsPresenterProtocol {
    weak var viewController: ProjectDetailsPresenterOutput?

    deinit {
        print("deinit \(self)")
    }
}
