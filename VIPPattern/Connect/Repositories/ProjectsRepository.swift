//
//  ProjectsRepository.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

protocol ProjectsRepositoryProtocol {
    func getProject(projectId: String, completion: @escaping ((Result<Project, MyError>) -> Void))
    func setProject(project: Project, completion: @escaping ((Result<Void, MyError>) -> Void))
    func deleteProject(projectId: String, completion: @escaping ((Result<Void, MyError>) -> Void))
    func getAllProjects(completion: @escaping ((Result<[Project], MyError>) -> Void))
    func getProjectsWithNeedFor(_ need: String, completion: @escaping ((Result<[Project], MyError>) -> Void))
    func getProjectsForUser(_ userId: String, completion: @escaping ((Result<[Project], MyError>) -> Void))
}

class ProjectsRepository: ProjectsRepositoryProtocol {
    private let firestoreService: FirestoreServiceProtocol

    init(firestoreService: FirestoreServiceProtocol) {
        self.firestoreService = firestoreService
    }

    deinit {
        print("deinit \(self)")
    }

    func getProject(projectId: String, completion: @escaping ((Result<Project, MyError>) -> Void)) {
        firestoreService.getDocument(documentPath: "projects/" + projectId, completion: completion)
    }

    func setProject(project: Project, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        var projectId: String
        if let id = project.id { projectId = id }
        else { projectId = UUID().uuidString }
        firestoreService.setDocument(documentPath: "projects/" + projectId, document: project, completion: completion)
    }

    func deleteProject(projectId: String, completion: @escaping ((Result<Void, MyError>) -> Void)) {
        firestoreService.deleteDocument(documentPath: "projects/" + projectId, completion: completion)
    }

    func getAllProjects(completion: @escaping ((Result<[Project], MyError>) -> Void)) {
        firestoreService.getCollection(collectionPath: "projects", isRealTime: false, completion: completion)
    }

    func getProjectsWithNeedFor(_ need: String, completion: @escaping ((Result<[Project], MyError>) -> Void)) {
        firestoreService.getCollectionWhereField("needTags", arrayContains: need, on: "projects", isRealTime: false, completion: completion)
    }

    func getProjectsForUser(_ userId: String, completion: @escaping ((Result<[Project], MyError>) -> Void)) {
        firestoreService.getCollectionWhereField("owner.id", isEqualTo: userId, on: "projects", isRealTime: false, completion: completion)
    }
}
