 //
//  ConversationDetailsPresenter.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

protocol ConversationDetailsPresenterProtocol: AnyObject {
    func interactor(didSucceedGetConversation response: ConversationDetails.GetConversationAction.Response.Success)
    func interactor(didFailGetConversation response: ConversationDetails.GetConversationAction.Response.Failure)
}

class ConversationDetailsPresenter: ConversationDetailsPresenterProtocol {
    weak var viewController: ConversationDetailsPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedGetConversation response: ConversationDetails.GetConversationAction.Response.Success) {
        //
    }

    func interactor(didFailGetConversation response: ConversationDetails.GetConversationAction.Response.Failure) {
        let viewModel = ConversationDetails.GetConversationAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailGetConversation: viewModel)
    }
}
