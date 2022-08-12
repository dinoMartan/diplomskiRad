//
//  OtherUserMessageTableViewCell.swift
//  Connect
//
//  Created by Dino Martan on 11.08.2022..
//

import UIKit

class OtherUserMessageTableViewCell: UITableViewCell {
    static let reuseIdentifier = "OtherUserMessageTableViewCell"

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!

    func setupWith(image: String, value: String) {
        profileImageView.setImageFromFireStore(image)
        messageLabel.text = value
    }
}
