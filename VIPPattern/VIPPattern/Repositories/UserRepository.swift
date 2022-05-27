//
//  UserRepository.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import UIKit

protocol UserRepositoryProtocol {
    func getUser(userId: String, completion: @escaping ((Result<User, MyError>) -> Void))
    func setUser(user: User, userImage: UIImage?, completion: @escaping ((Result<Void, MyError>) -> Void))
}

class UserRepository: UserRepositoryProtocol {
    private let firestoreService: FirestoreServiceProtocol

    init(firestoreService: FirestoreServiceProtocol) {
        self.firestoreService = firestoreService
    }

    func getUser(userId: String, completion: @escaping ((Result<User, MyError>) -> Void)) {
        firestoreService.getDocument(documentPath: "users/" + userId, completion: completion)
    }

    func setUser(user: User, userImage: UIImage?, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        guard let id = user.id else {
            completion(.failure(MyError(type: .codableError, message: "userId nije pronađen!")))
            return
        }
        var user = user
        if let userImageData = userImage?.jpegData(compressionQuality: 0.1) {
            firestoreService.uploadImage(data: userImageData) { [weak self] result in
                switch result {
                case .success(let imageUrl):
                    user.profileImage = imageUrl
                case .failure(_):
                    break
                }
                self?.firestoreService.setDocument(documentPath: "users/" + id, document: user, completion: completion)
            }
        } else {
            firestoreService.setDocument(documentPath: "users/" + id, document: user, completion: completion)
        }
    }
}
