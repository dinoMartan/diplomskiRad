 //
//  EditProjectInteractor.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

protocol EditProjectInteractorProtocol {
    func saveProject(_ project: Project?)
    func getProject()
}

class EditProjectInteractor: EditProjectInteractorProtocol {
    var presenter: EditProjectPresenterProtocol?

    private let projectsRepository: ProjectsRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let keychainService: KeychainServiceProtocol

    private let project: Project?

    init(project: Project?, projectsRepository: ProjectsRepositoryProtocol, userRepository: UserRepositoryProtocol, keychainService: KeychainServiceProtocol) {
        self.project = project
        self.projectsRepository = projectsRepository
        self.userRepository = userRepository
        self.keychainService = keychainService
    }

    deinit {
        print("deinit \(self)")
    }
}

extension EditProjectInteractor {
    func saveProject(_ project: Project?) {
        guard var project = project else { return }
        getUser { [weak self] user in
            project.owner = user.getUserNested()
            self?.setProject(project)
        }
    }

    private func getUser(success: @escaping ((User) -> Void)) {
        guard let userId = keychainService.getUserId() else {
            // TODO: handle error
            return
        }
        userRepository.getUser(userId: userId) { result in
            switch result {
            case .success(let user):
                success(user)
            case .failure(let myError):
                break
                // TODO: handle error
            }
        }
    }

    private func setProject(_ project: Project) {
        projectsRepository.setProject(project: project) { result in
            switch result {
            case .success(_):
                break
                // TODO: handle success
            case .failure(let myError):
                break
                // TODO: handle error
            }
        }
    }

    func getProject() {
        projectsRepository.getProject(projectId: "0114ECC1-0541-4830-AA71-B8EF9DBEB682") { result in
            switch result {
            case .success(let project):
                print(project)
            case .failure(let myError):
                print(myError)
            }
        }
    }
}
