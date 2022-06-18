//
//  UIFont+Extension.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import UIKit

extension UIFont {
    enum Font: String {
        case openSansBold = "OpenSans-Bold"
        case openSansExtraBold = "OpenSans-ExtraBold"
        case openSansMedium = "OpenSans-Medium"
        case openSansMediumItalic = "OpenSans-MediumItalic"
    }

    convenience init?(_ font: Font, size: CGFloat = 12) {
        self.init(name: font.rawValue, size: size)
    }
}
