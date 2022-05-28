 //
//  EditProjectPresenter.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

protocol EditProjectPresenterProtocol: AnyObject {
}

class EditProjectPresenter: EditProjectPresenterProtocol {
    weak var viewController: EditProjectPresenterOutput?

    deinit {
        print("deinit \(self)")
    }
}
