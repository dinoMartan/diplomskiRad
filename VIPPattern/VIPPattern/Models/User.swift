//
//  User.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import FirebaseFirestoreSwift
import Foundation

struct User: Codable {
    @DocumentID var id: String?
    let username: String?
    let firstName: String?
    let lastName: String?
    let email: String?

    init(id: String?, username: String?, firstName: String?, lastName: String?, email: String?) {
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }

    init(id: String?) {
        self.id = id
        self.username = nil
        self.firstName = nil
        self.lastName = nil
        self.email = nil
    }
}
