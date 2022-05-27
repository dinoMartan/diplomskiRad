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
    var profileImage: String?
}
