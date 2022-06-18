 //
//  ProjectDetailsInteractor.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

protocol ProjectDetailsInteractorProtocol {
}

class ProjectDetailsInteractor: ProjectDetailsInteractorProtocol {
    var presenter: ProjectDetailsPresenterProtocol?

    private let projectsRepository: ProjectsRepositoryProtocol

    init(projectsRepository: ProjectsRepositoryProtocol) {
        self.projectsRepository = projectsRepository
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProjectDetailsInteractor {
}
