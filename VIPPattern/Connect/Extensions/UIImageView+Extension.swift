//
//  UIImageView+Extension.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import FirebaseStorage
import Kingfisher
import UIKit

extension UIImageView {
    func setImageFromFireStore(_ image: String) {
        let storage = Storage.storage().reference().child(image)
        storage.downloadURL { [weak self] url, _ in
            self?.kf.setImage(with: url)
        }
    }
}
