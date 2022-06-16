 //
//  HomeInteractor.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol HomeInteractorProtocol {
    func getAllProjects(request: Home.GetAllProjectsAction.Request)
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?

    private let projectsRepository: ProjectsRepositoryProtocol

    init(projectsRepository: ProjectsRepositoryProtocol) {
        self.projectsRepository = projectsRepository
    }

    deinit {
        print("deinit \(self)")
    }
}

extension HomeInteractor {
    func getAllProjects(request: Home.GetAllProjectsAction.Request) {
        projectsRepository.getAllProjects { [weak self] result in
            switch result {
            case .success(let projects):
                self?.presenter?.interactor(didSucceedGetAllProjects: Home.GetAllProjectsAction.Response.Success(projects: projects))
            case .failure(let myError):
                self?.presenter?.interactor(didFailGetAllProjects: Home.GetAllProjectsAction.Response.Failure(myError: myError))
            }
        }
    }
}
