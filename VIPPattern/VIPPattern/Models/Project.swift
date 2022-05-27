//
//  Project.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import FirebaseFirestoreSwift
import Foundation

struct Project {
    @DocumentID var id: String?
    let title: String?
    let createdAt: Date?
    let description: String?
    let haveTags: [String]?
    let needTags: [String]?
    let owner: User?
}
