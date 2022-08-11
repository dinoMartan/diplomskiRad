//
//  Message.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

struct Message: Codable, Equatable {
    let createdAt: Date?
    let type: MessageType?
    let senderId: String?
    let value: String?
}

enum MessageType: String, RawRepresentable, Codable {
    case text = "text"
}
