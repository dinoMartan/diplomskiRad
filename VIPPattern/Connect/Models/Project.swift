//
//  Project.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import FirebaseFirestoreSwift
import Foundation

struct Project: Codable {
    @DocumentID var id: String?
    var title: String?
    var createdAt: Date?
    var description: String?
    var haveTags: [String]?
    var needTags: [String]?
    var owner: UserNested?
}
