//
//  ProfileSettingTableViewCell.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import UIKit

class ProfileSettingTableViewCell: UITableViewCell {
    static let identifier = "ProfileSettingTableViewCell"

    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var label: UILabel!

    func setupWith(_ setting: Profile.Setting?) {
        icon.image = UIImage(systemName: setting?.icon ?? "")
        label.text = setting?.value
    }
}
