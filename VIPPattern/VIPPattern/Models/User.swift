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
    var username: String?
    var firstName: String?
    var lastName: String?
    let email: String?
    var profileImage: String?
}
