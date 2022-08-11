//
//  FirestoreServiceMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 06.08.2022..
//

import Foundation
@testable import Connect

class FirestoreServiceMock: FirestoreServiceProtocol {
    var myError: MyError?
    var expectedResponse: Codable?

    var getDocumentCalled = false
    var getDocumentCounter = 0
    var getDocumentDocumentPath: String?

    func getDocument<T: Codable>(documentPath: String, completion: @escaping ((Result<T, MyError>) -> Void)) {
        getDocumentCalled = true
        getDocumentCounter += 1
        self.getDocumentDocumentPath = documentPath

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

    func setDocument<T: Codable>(documentPath: String, document: T, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        //
    }
    
    func deleteDocument(documentPath: String, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        //
    }
    
    func observeDocument<T: Codable>(documentPath: String, completion: @escaping ((Result<T, MyError>) -> Void)) {
        //
    }
    
    func uploadImage(data: Data, completion: @escaping ((Result<String?, MyError>) -> Void)) {
        //
    }
    
    func getCollection<T: Codable>(collectionPath: String, isRealTime: Bool, completion: @escaping ((Result<[T], MyError>) -> Void)) {
        //
    }
    
    func getCollectionWhereField<T: Codable>(_ field: String, isEqualTo: Any, on collectionPath: String, isRealTime: Bool, completion: @escaping ((Result<[T], MyError>) -> Void))  {
        //
    }
    
    func getCollectionWhereField<T: Codable>(_ field: String, arrayContains: Any, on collectionPath: String, isRealTime: Bool, completion: @escaping ((Result<[T], MyError>) -> Void)) {
        //
    }
}
