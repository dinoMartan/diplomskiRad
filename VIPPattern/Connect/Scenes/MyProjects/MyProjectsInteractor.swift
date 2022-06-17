 //
//  MyProjectsInteractor.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol MyProjectsInteractorProtocol {
    func getMyProjects(request: MyProjects.GetMyProjectsAction.Request)
}

class MyProjectsInteractor: MyProjectsInteractorProtocol {
    var presenter: MyProjectsPresenterProtocol?

    private let projectsRepository: ProjectsRepositoryProtocol
    private let keychainService: KeychainServiceProtocol

    init(projectsRepository: ProjectsRepositoryProtocol, keychainService: KeychainServiceProtocol) {
        self.projectsRepository = projectsRepository
        self.keychainService = keychainService
    }

    deinit {
        print("deinit \(self)")
    }
}

extension MyProjectsInteractor {
    func getMyProjects(request: MyProjects.GetMyProjectsAction.Request) {
        guard let userId = keychainService.getUserId() else { return }
        projectsRepository.getProjectsForUser(userId) { [weak self] result in
            switch result {
            case .success(let projects):
                let response = MyProjects.GetMyProjectsAction.Response.Success(projects: projects)
                self?.presenter?.interactor(didSucceedGetMyProjects: response)
            case .failure(let myError):
                let response = MyProjects.GetMyProjectsAction.Response.Failure(myError: myError)
                self?.presenter?.interactor(didFailGetMyProjects: response)
            }
        }
    }
}
