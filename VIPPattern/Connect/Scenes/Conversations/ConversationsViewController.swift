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

    private var conversations = [Conversations.CConversation]() {
        didSet {
            conversationsView?.tableView.reloadData()
        }
    }

    override func loadView() {
        super.loadView()
        self.view = conversationsView
        setupTableView()
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
    private func setupTableView() {
        conversationsView?.tableView.dataSource = self
        conversationsView?.tableView.delegate = self
        conversationsView?.tableView.register(UINib(nibName: ConversationsTableViewCell.reuseIdentifier, bundle: nil),
                                              forCellReuseIdentifier: ConversationsTableViewCell.reuseIdentifier)
    }
}

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        conversations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConversationsTableViewCell.reuseIdentifier, for: indexPath) as? ConversationsTableViewCell else { return UITableViewCell() }
        let conversation = conversations[indexPath.row]
        cell.setupWith(conversation)
        return cell
    }
}

extension ConversationsViewController: ConversationsPresenterOutput {
    func presenter(didSucceedGetUsersConversations viewModel: Conversations.GetUsersConversationsAction.ViewModel.Success) {
        self.conversations = viewModel.conversations
    }

    func presenter(didFailGetUsersConversations viewModel: Conversations.GetUsersConversationsAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
