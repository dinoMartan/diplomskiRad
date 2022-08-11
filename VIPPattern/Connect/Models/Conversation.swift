//
//  Conversation.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import FirebaseFirestoreSwift
import Foundation

struct Conversation: Codable, Equatable {
    @DocumentID var id: String?
    let project: ProjectNested?
    let users: [UserNested]?
    let userIds: [String]?
    let createdAt: Date?
    let messages: [Message]?
}
