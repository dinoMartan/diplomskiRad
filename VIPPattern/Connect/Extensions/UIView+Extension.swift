//
//  UIView+Extension.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import UIKit

extension UIView {
    func setShadowAndCornerRadius() {
        self.layer.cornerRadius = 15
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowColor = UIColor.darkGray.cgColor
    }
}
