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

    func setupWith(_ profileSetting: Profile.GetUserDataAction.Setting) {
        icon.image = UIImage(systemName: profileSetting.icon ?? "")
        label.text = profileSetting.value
    }
}
