//
//  ProjectsRepositoryMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect

class ProjectsRepositoryMock {
    private let dataMock = DataMock()

    var myError: MyError?

    var getProjectCalled = false
    var getProjectCounter = 0
    var projectId: String?

    var setProjectCalled = false
    var setProjectCounter = 0
    var project: Project?

    var deleteProjectCalled = false
    var deleteProjectCounter = 0

    var getAllProjectsCalled = false
    var getAllProjectsCounter = 0

    var getProjectsWithNeedForCalled = false
    var getProjectsWithNeedForCounter = 0
    var need: String?

    var getProjectsForUserCalled = false
    var getProjectsForUserCounter = 0
    var userId: String?
}

extension ProjectsRepositoryMock: ProjectsRepositoryProtocol {
    func getProject(projectId: String, completion: @escaping ((Result<Project, MyError>) -> Void)) {
        getProjectCalled = true
        getProjectCounter += 1
        self.projectId = projectId

        guard let myError = myError else {
            completion(.success(dataMock.getProject()))
            return
        }
        completion(.failure(myError))
    }

    func setProject(project: Project, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        setProjectCalled = true
        setProjectCounter += 1
        self.project = project
    
        guard let myError = myError else {
            completion(.success(()))
            return
        }
        completion(.failure(myError))
    }

    func deleteProject(projectId: String, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        deleteProjectCalled = true
        deleteProjectCounter += 1
        self.projectId = projectId

        guard let myError = myError else {
            completion(.success(()))
            return
        }
        completion(.failure(myError))
    }

    func getAllProjects(completion: @escaping ((Result<[Project], MyError>) -> Void)) {
        getAllProjectsCalled = true
        getAllProjectsCounter += 1

        guard let myError = myError else {
            completion(.success([dataMock.getProject()]))
            return
        }
        completion(.failure(myError))
    }

    func getProjectsWithNeedFor(_ need: String, completion: @escaping ((Result<[Project], MyError>) -> Void)) {
        getProjectsWithNeedForCalled = true
        getProjectsWithNeedForCounter += 1
        self.need = need

        guard let myError = myError else {
            completion(.success([dataMock.getProject()]))
            return
        }
        completion(.failure(myError))
    }

    func getProjectsForUser(_ userId: String, completion: @escaping ((Result<[Project], MyError>) -> Void)) {
        getProjectsForUserCalled = true
        getProjectsForUserCounter += 1
        self.userId = userId

        guard let myError = myError else {
            completion(.success([dataMock.getProject()]))
            return
        }
        completion(.failure(myError))
    }
}
