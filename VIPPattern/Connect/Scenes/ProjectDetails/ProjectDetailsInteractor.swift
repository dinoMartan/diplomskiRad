 //
//  ProjectDetailsInteractor.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

protocol ProjectDetailsInteractorProtocol {
    func getProjectDetails(request: ProjectDetails.GetProjectDetailsAction.Request)
}

class ProjectDetailsInteractor: ProjectDetailsInteractorProtocol {
    var presenter: ProjectDetailsPresenterProtocol?

    private let projectsRepository: ProjectsRepositoryProtocol

    private let projectId: String

    init(projectsRepository: ProjectsRepositoryProtocol, projectId: String) {
        self.projectsRepository = projectsRepository
        self.projectId = projectId
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProjectDetailsInteractor {
    func getProjectDetails(request: ProjectDetails.GetProjectDetailsAction.Request) {
        projectsRepository.getProject(projectId: projectId) { [weak self] result in
            switch result {
            case .success(let project):
                let response = ProjectDetails.GetProjectDetailsAction.Response.Success(project: project)
                self?.presenter?.interactor(didSucceedGetProjectDetails: response)
            case .failure(let myError):
                let response = ProjectDetails.GetProjectDetailsAction.Response.Failure(myError: myError)
                self?.presenter?.interactor(didFailGetProjectDetails: response)
            }
        }
    }
}
