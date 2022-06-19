 //
//  ConversationDetailsViewController.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import UIKit

protocol ConversationDetailsPresenterOutput: AnyObject {
    func presenter(didSucceedGetConversation viewModel: ConversationDetails.GetConversationAction.ViewModel.Success)
    func presenter(didFailGetConversation viewModel: ConversationDetails.GetConversationAction.ViewModel.Failure)
}

class ConversationDetailsViewController: UIViewController {
    var conversationDetailsView: ConversationDetailsView?
    var interactor: ConversationDetailsInteractorProtocol?
    var router: ConversationDetailsRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = conversationDetailsView
        navigationController?.isNavigationBarHidden = false
        setupTableView()
        let request = ConversationDetails.GetConversationAction.Request()
        interactor?.getConversation(request: request)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        router?.shouldClose()
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ConversationDetailsViewController {
    private func setupTableView() {
        conversationDetailsView?.tableView.delegate = self
        conversationDetailsView?.tableView.dataSource = self
    }
}

extension ConversationDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

extension ConversationDetailsViewController: ConversationDetailsPresenterOutput {
    func presenter(didSucceedGetConversation viewModel: ConversationDetails.GetConversationAction.ViewModel.Success) {
        // TODO: add UI
    }

    func presenter(didFailGetConversation viewModel: ConversationDetails.GetConversationAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
