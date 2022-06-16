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
}
