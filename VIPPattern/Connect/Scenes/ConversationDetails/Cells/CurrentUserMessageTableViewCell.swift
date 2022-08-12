//
//  CurrentUserMessageTableViewCell.swift
//  Connect
//
//  Created by Dino Martan on 11.08.2022..
//

import UIKit

class CurrentUserMessageTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CurrentUserMessageTableViewCell"

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!

    func setupWith(image: String, value: String) {
        profileImageView.setImageFromFireStore(image)
        messageLabel.text = value
    }
}
