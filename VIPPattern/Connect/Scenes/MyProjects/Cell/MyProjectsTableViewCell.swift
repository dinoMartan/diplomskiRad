//
//  MyProjectsTableViewCell.swift
//  Connect
//
//  Created by Dino Martan on 17.06.2022..
//

import UIKit

class MyProjectsTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var createdAtLabel: UILabel!
    @IBOutlet private weak var needTagsLabel: UILabel!
    @IBOutlet private weak var haveTagsLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!

    static let reuseIdentifier = "MyProjectsTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.setShadowAndCornerRadius()
    }

    func setupWith(project: MyProjects.MProject) {
        titleLabel.text = project.title
        createdAtLabel.text = project.createdAt
        needTagsLabel.text = project.needTags
        haveTagsLabel.text = project.haveTags
    }
}
