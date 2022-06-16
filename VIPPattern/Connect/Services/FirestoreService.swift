//
//  FirestoreService.swift
//  Connect
//
//  Created by Dino Martan on 26.05.2022..
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import Foundation

protocol FirestoreServiceProtocol {
    func getDocument<T: Codable>(documentPath: String, completion: @escaping ((Result<T, MyError>) -> Void))
    func setDocument<T: Codable>(documentPath: String, document: T, completion: @escaping ((Result<Void, MyError>) -> Void))
    func uploadImage(data: Data, completion: @escaping ((Result<String?, MyError>) -> Void))
    func getCollection<T: Codable>(collectionPath: String, completion: @escaping ((Result<[T], MyError>) -> Void))
}

class FirestoreService: FirestoreServiceProtocol {
    private let firestore: Firestore
    private let storageReference: StorageReference

    init() {
        firestore = Firestore.firestore()
        storageReference = Storage.storage().reference()
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

    func getCollection<T: Codable>(collectionPath: String, completion: @escaping ((Result<[T], MyError>) -> Void)) {
        let collectionReference = firestore.collection(collectionPath)
        collectionReference.getDocuments { querySnapshot, error in
            guard let querySnapshot = querySnapshot,
            error == nil else {
                completion(.failure(MyError(type: .firestoreFailed, message: error?.localizedDescription)))
                return
            }
            var results = [T]()
            for document in querySnapshot.documents {
                do {
                    let result = try document.data(as: T.self)
                    results.append(result)
                }
                catch { continue }
            }
            completion(.success(results))
        }
    }
}

extension FirestoreService {
    func uploadImage(data: Data, completion: @escaping ((Result<String?, MyError>) -> Void)) {
        let imageReference = storageReference.child("/images/\(UUID().uuidString).jpeg")
        imageReference.putData(data) { result in
            switch result {
            case .success(let storageMetaData):
                completion(.success(storageMetaData.path))
            case.failure(let error):
                completion(.failure(MyError(type: .firestoreFailed, message: error.localizedDescription)))
            }
        }
    }
}
