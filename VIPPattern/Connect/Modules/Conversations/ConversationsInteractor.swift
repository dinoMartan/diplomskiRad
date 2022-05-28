 //
//  ConversationsInteractor.swift
//  VIPPattern
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol ConversationsInteractorProtocol {
}

class ConversationsInteractor: ConversationsInteractorProtocol {
    var presenter: ConversationsPresenterProtocol?

    deinit {
        print("deinit \(self)")
    }
}

extension ConversationsInteractor {
}
