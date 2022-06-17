//
//  HomeTableViewCell.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet private weak var ownerImageView: UIImageView!
    @IBOutlet private weak var ownerUsernameLabel: UILabel!
    @IBOutlet private weak var projectTitleLabel: UILabel!
    @IBOutlet private weak var projectNeedTagsLabel: UILabel!

    static let identifier = "HomeTableViewCell"

    func setupWith(project: Home.HProject) {
        ownerImageView.setImageFromFireStore(project.ownerImage ?? "")
        ownerUsernameLabel.text = project.ownerUsername
        projectTitleLabel.text = project.projectTitle
        projectNeedTagsLabel.text = project.projectNeeds
    }
}
