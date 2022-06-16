//
//  User.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import FirebaseFirestoreSwift
import Foundation

struct User: Codable, Equatable {
    @DocumentID var id: String?
    var username: String?
    var firstName: String?
    var lastName: String?
    let email: String?
    var profileImage: String?

    func getUserNested() -> UserNested {
        UserNested(id: id,
                   username: username,
                   firstName: firstName,
                   lastName: lastName,
                   email: email,
                   profileImage: profileImage)
    }
}

struct UserNested: Codable, Equatable {
    let id: String?
    let username: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let profileImage: String?

    func getUser() -> User {
        User(id: id,
             username: username,
             firstName: firstName,
             lastName: lastName,
             email: email,
             profileImage: profileImage)
    }
}
