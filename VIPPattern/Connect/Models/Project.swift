//
//  Project.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import FirebaseFirestoreSwift
import Foundation

struct Project: Codable, Equatable {
    @DocumentID var id: String?
    var title: String?
    var createdAt: Date?
    var description: String?
    var haveTags: [String]?
    var needTags: [String]?
    var owner: UserNested?

    func getProjectNested() -> ProjectNested {
        ProjectNested(id: id,
                      title: title,
                      createdAt: createdAt,
                      description: description,
                      haveTags: haveTags,
                      needTags: needTags,
                      owner: owner)
    }
}

struct ProjectNested: Codable, Equatable {
    let id: String?
    let title: String?
    let createdAt: Date?
    let description: String?
    let haveTags: [String]?
    let needTags: [String]?
    let owner: UserNested?

    func getProject() -> Project {
        Project(id: id,
                title: title,
                createdAt: createdAt,
                description: description,
                haveTags: haveTags,
                needTags: needTags,
                owner: owner)
    }
}
