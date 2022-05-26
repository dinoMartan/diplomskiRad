//
//  FirestoreService.swift
//  VIPPattern
//
//  Created by Dino Martan on 26.05.2022..
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

protocol FirestoreServiceProtocol {
    func getDocument<T: Codable>(documentPath: String, completion: @escaping ((Result<T, MyError>) -> Void))
    func setDocument<T: Codable>(documentPath: String, document: T, completion: @escaping ((Result<Void, MyError>) -> Void))
}

class FirestoreService: FirestoreServiceProtocol {
    private let firestore: Firestore

    init() {
        firestore = Firestore.firestore()
    }

    func getDocument<T: Codable>(documentPath: String, completion: @escaping ((Result<T, MyError>) -> Void)) {
        let documentReference = firestore.document(documentPath)
        documentReference.getDocument(as: T.self) { result in
            switch result {
            case .success(let object):
                completion(.success(object))
            case .failure(let error):
                completion(.failure(MyError(type: .codableError, message: error.localizedDescription)))
            }
        }
    }

    func setDocument<T: Codable>(documentPath: String, document: T, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        let documentReference = firestore.document(documentPath)
        do {
            try documentReference.setData(from: document)
            completion(.success(()))
        }
        catch {
            completion(.failure(MyError(type: .codableError, message: error.localizedDescription)))
        }
        
    }
}
