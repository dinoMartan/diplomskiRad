 //
//  ConversationsViewController.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol ConversationsPresenterOutput: AnyObject {
    func presenter(didSucceedGetUsersConversations viewModel: Conversations.GetUsersConversationsAction.ViewModel.Success)
    func presenter(didFailGetUsersConversations viewModel: Conversations.GetUsersConversationsAction.ViewModel.Failure)
}

class ConversationsViewController: UIViewController {
    var conversationsView: ConversationsView?
    var interactor: ConversationsInteractorProtocol?
    var router: ConversationsRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = conversationsView
        let request = Conversations.GetUsersConversationsAction.Request()
        interactor?.getUsersConversations(request: request)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            router?.shouldClose()
        }
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ConversationsViewController {
}

extension ConversationsViewController: ConversationsPresenterOutput {
    func presenter(didSucceedGetUsersConversations viewModel: Conversations.GetUsersConversationsAction.ViewModel.Success) {
        print(viewModel.conversations)
    }

    func presenter(didFailGetUsersConversations viewModel: Conversations.GetUsersConversationsAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
