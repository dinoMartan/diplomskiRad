 //
//  ConversationsPresenter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol ConversationsPresenterProtocol: AnyObject {
}

class ConversationsPresenter: ConversationsPresenterProtocol {
    weak var viewController: ConversationsPresenterOutput?

    deinit {
        print("deinit \(self)")
    }
}
