//
//  Date+Extension.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

extension Date {
    enum Style: String {
        case short = "dd.MM.yy"
    }

    func toString(_ style: Style) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = style.rawValue
        return formatter.string(from: self)
    }
}
