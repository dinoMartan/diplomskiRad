//
//  FirestoreServiceMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 06.08.2022..
//

import Foundation
@testable import Connect

class FirestoreServiceMock: FirestoreServiceProtocol {
    var expectedResponse: Any?
    var myError: MyError?

    var getDocumentCalled = false
    var getDocumentCounter = 0
    var getDocumentDocumentPath: String?

    var setDocumentCalled = false
    var setDocumentCounter = 0
    var setDocumentDocumentPath: String?

    var deleteDocumentCalled = false
    var deleteDocumentCounter = 0
    var deleteDocumentDocumentPath: String?

    var observeDocumentCalled = false
    var observeDocumentCounter = 0
    var observeDocumentDocumentPath: String?

    var uploadImageCalled = false
    var uploadImageCounter = 0
    var uploadImageData: Data?

    var getCollectionCalled = false
    var getCollectionCounter = 0
    var getCollectionCollectionPath: String?
    var getCollectionIsRealTime: Bool?

    var getCollectionWhereFieldCalled = false
    var getCollectionWhereFieldCounter = 0
    var getCollectionWhereFieldField: String?
    var getCollectionWhereFieldIsEqualTo: Any?
    var getCollectionWhereFieldCollectionPath: String?
    var getCollectionWhereFieldIsRealTime: Bool?

    var getCollectionWhereFieldArrayContains: Any?

    func getDocument<T: Codable>(documentPath: String, completion: @escaping ((Result<T, MyError>) -> Void)) {
        getDocumentCalled = true
        getDocumentCounter += 1
        self.getDocumentDocumentPath = documentPath

        handleCompletion(completion)
    }

    func setDocument<T: Codable>(documentPath: String, document: T, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        setDocumentCalled = true
        setDocumentCounter += 1
        setDocumentDocumentPath = documentPath

        handleVoidCompletion(completion)
    }

    func deleteDocument(documentPath: String, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        deleteDocumentCalled = true
        deleteDocumentCounter += 1
        deleteDocumentDocumentPath = documentPath

        handleVoidCompletion(completion)
    }

    func observeDocument<T: Codable>(documentPath: String, completion: @escaping ((Result<T, MyError>) -> Void)) {
        observeDocumentCalled = true
        observeDocumentCounter += 1
        observeDocumentDocumentPath = documentPath

        handleCompletion(completion)
    }

    func uploadImage(data: Data, completion: @escaping ((Result<String?, MyError>) -> Void)) {
        uploadImageCalled = true
        uploadImageCounter += 1
        uploadImageData = data

        handleCompletion(completion)
    }

    func getCollection<T: Codable>(collectionPath: String, isRealTime: Bool, completion: @escaping ((Result<[T], MyError>) -> Void)) {
        getCollectionCalled = true
        getCollectionCounter += 1
        getCollectionCollectionPath = collectionPath
        getCollectionIsRealTime = isRealTime

        handleCompletion(completion)
    }

    func getCollectionWhereField<T: Codable>(_ field: String, isEqualTo: Any, on collectionPath: String, isRealTime: Bool, completion: @escaping ((Result<[T], MyError>) -> Void))  {
        getCollectionWhereFieldCalled = true
        getCollectionWhereFieldCounter += 1
        getCollectionWhereFieldField = field
        getCollectionWhereFieldIsEqualTo = isEqualTo
        getCollectionWhereFieldCollectionPath = collectionPath
        getCollectionWhereFieldIsRealTime = isRealTime

        handleCompletion(completion)
    }

    func getCollectionWhereField<T: Codable>(_ field: String, arrayContains: Any, on collectionPath: String, isRealTime: Bool, completion: @escaping ((Result<[T], MyError>) -> Void)) {
        getCollectionWhereFieldCalled = true
        getCollectionWhereFieldCounter += 1
        getCollectionWhereFieldField = field
        getCollectionWhereFieldArrayContains = arrayContains
        getCollectionWhereFieldCollectionPath = collectionPath
        getCollectionWhereFieldIsRealTime = isRealTime

        handleCompletion(completion)
    }

    private func handleCompletion<T: Codable>(_ completion: @escaping ((Result<T, MyError>) -> Void)) {
        guard let myError = myError else {
            guard let expectedResponse = expectedResponse else {
                return
            }
            completion(.success(expectedResponse as! T))
            return
        }
        completion(.failure(myError))
    }

    private func handleVoidCompletion(_ completion: @escaping ((Result<Void, MyError>) -> Void)) {
        guard let myError = myError else {
            guard expectedResponse != nil else {
                return
            }
            completion(.success(()))
            return
        }
        completion(.failure(myError))
    }
}
