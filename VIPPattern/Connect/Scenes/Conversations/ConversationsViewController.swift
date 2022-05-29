 //
//  ConversationsViewController.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol ConversationsPresenterOutput: AnyObject {
}

class ConversationsViewController: UIViewController {
    var viewConversations: ConversationsView?
    var interactor: ConversationsInteractorProtocol?
    var router: ConversationsRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = viewConversations
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
}
