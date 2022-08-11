//
//  ConversationsTableViewCell.swift
//  Connect
//
//  Created by Dino Martan on 11.08.2022..
//

import UIKit

class ConversationsTableViewCell: UITableViewCell {
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastMessageLabel: UILabel!

    static let reuseIdentifier = "ConversationsTableViewCell"

    func setupWith(_ conversation: Conversations.CConversation) {
        profileImageView.setImageFromFireStore(conversation.image ?? "")
        nameLabel.text = conversation.name
        lastMessageLabel.text = conversation.lastMessage
    }
}
