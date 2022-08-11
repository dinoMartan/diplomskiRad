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

    private var messages = [ConversationDetails.CDMessage]() {
        didSet {
            conversationDetailsView?.tableView.reloadData()
        }
    }

    override func loadView() {
        super.loadView()
        self.view = conversationDetailsView
        navigationController?.isNavigationBarHidden = false
        setupTableView()
        setupTextField()
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
        conversationDetailsView?.tableView.register(UINib(nibName: CurrentUserMessageTableViewCell.reuseIdentifier, bundle: nil),
                                                    forCellReuseIdentifier: CurrentUserMessageTableViewCell.reuseIdentifier)
        conversationDetailsView?.tableView.register(UINib(nibName: OtherUserMessageTableViewCell.reuseIdentifier, bundle: nil),
                                                    forCellReuseIdentifier: OtherUserMessageTableViewCell.reuseIdentifier)
    }

    private func setupTextField() {
        conversationDetailsView?.textField.delegate = self
    }
}

extension ConversationDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.isCurrentUsersMessage {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentUserMessageTableViewCell.reuseIdentifier, for: indexPath) as? CurrentUserMessageTableViewCell else { return UITableViewCell() }
            cell.setupWith(image: message.image, value: message.value)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherUserMessageTableViewCell.reuseIdentifier, for: indexPath) as? OtherUserMessageTableViewCell else { return UITableViewCell() }
            cell.setupWith(image: message.image, value: message.value)
            return cell
        }
    }
}

extension ConversationDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let message = textField.text else {
            return false
        }
        sendMessage(message)
        return true
    }

    private func sendMessage(_ message: String) {
        
    }
}

extension ConversationDetailsViewController: ConversationDetailsPresenterOutput {
    func presenter(didSucceedGetConversation viewModel: ConversationDetails.GetConversationAction.ViewModel.Success) {
        self.messages = viewModel.messages
        self.title = viewModel.pojectTitle
    }

    func presenter(didFailGetConversation viewModel: ConversationDetails.GetConversationAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
