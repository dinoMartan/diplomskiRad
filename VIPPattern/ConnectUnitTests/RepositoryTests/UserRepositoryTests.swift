//
//  UserRepositoryTests.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 06.08.2022..
//

import Foundation
@testable import Connect
import XCTest

class UserRepositoryTests: XCTestCase {
    private var sut: UserRepository!
    private var firestoreServiceMock: FirestoreServiceMock!
    private var dataMock: DataMock!

    override func setUpWithError() throws {
        firestoreServiceMock = FirestoreServiceMock()
        sut = UserRepository(firestoreService: firestoreServiceMock)
        dataMock = DataMock()
    }

    override func tearDownWithError() throws {
        firestoreServiceMock = nil
        sut = nil
        dataMock = nil
    }
}

// MARK: getUser(userId: String, completion: @escaping ((Result<User, MyError>) -> Void)) tests
extension UserRepositoryTests {
    func testGetUser_WhenCalledWithUserId_ShouldCallFirestoreServiceGetDocumentWithDocumentPath() {
        // Given
        let userId = "user id"
        let expectedDocumentPath = "users/" + userId

        // When
        sut.getUser(userId: userId) { _ in
            //
        }

        // Then
        XCTAssertTrue(firestoreServiceMock.getDocumentCalled)
        XCTAssertEqual(firestoreServiceMock.getDocumentCounter, 1)
        XCTAssertEqual(firestoreServiceMock.getDocumentDocumentPath, expectedDocumentPath)
    }

    func testGetUser_WhenCalledWithUserIdOnSuccess_ShouldCallCompletionWithUser() {
        // Given
        let expectation = expectation(description: "expectation")
        let userId = dataMock.userId ?? ""
        let expectedResponse = dataMock.getUser()
        firestoreServiceMock.expectedResponse = expectedResponse

        // When
        sut.getUser(userId: userId) { result in
            guard case .success(let user) = result, user.id == userId else {
                return
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }

    func testGetUser_WhenCalledWithUserIdOnFailure_ShouldCallCompletionMyError() {
        // Given
        let expectation = expectation(description: "expectation")
        let userId = dataMock.userId ?? ""
        let myError = MyError(type: .firestoreFailed, message: nil)
        firestoreServiceMock.myError = myError

        // When
        sut.getUser(userId: userId) { result in
            guard case .failure(let error) = result, myError == error else {
                return
            }
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }
}
