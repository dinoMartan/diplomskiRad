 //
//  EditProjectInteractor.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

protocol EditProjectInteractorProtocol {
    func saveProject(request: EditProject.SaveProjectAction.Request)
    func getProject(request: EditProject.GetProjectAction.Request)
}

class EditProjectInteractor: EditProjectInteractorProtocol {
    var presenter: EditProjectPresenterProtocol?

    private let projectsRepository: ProjectsRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let keychainService: KeychainServiceProtocol

    private var currentProject: Project?
    private let projectId: String?

    init(projectId: String?,
         projectsRepository: ProjectsRepositoryProtocol,
         userRepository: UserRepositoryProtocol,
         keychainService: KeychainServiceProtocol) {
        self.projectId = projectId
        self.projectsRepository = projectsRepository
        self.userRepository = userRepository
        self.keychainService = keychainService
    }

    deinit {
        print("deinit \(self)")
    }
}

extension EditProjectInteractor {
    func saveProject(request: EditProject.SaveProjectAction.Request) {
        guard currentProject == nil else {
            updateCurrentProject(with: request)
            setCurrentProject()
            return
        }
        getUser { [weak self] user in
            guard let self = self else { return }
            let project = self.getNewProjectFromRequest(request,
                                                        owner: user.getUserNested())
            self.currentProject = project
            self.setCurrentProject()
        }
    }

    private func getNewProjectFromRequest(_ request: EditProject.SaveProjectAction.Request, owner: UserNested) -> Project {
        Project(id: UUID().uuidString,
                title: request.title,
                createdAt: Date(),
                description: request.description,
                haveTags: request.haveTags?.map({ $0.lowercased() }),
                needTags: request.needTags?.map({ $0.lowercased() }),
                owner: owner)
    }

    private func updateCurrentProject(with request: EditProject.SaveProjectAction.Request) {
        guard var updatedProject = currentProject else { return }
        updatedProject.title = request.title
        updatedProject.description = request.description
        updatedProject.haveTags = request.haveTags?.map({ $0.lowercased() })
        updatedProject.needTags = request.needTags?.map({ $0.lowercased() })
        currentProject = updatedProject
    }

    private func getUser(success: @escaping ((User) -> Void)) {
        guard let userId = keychainService.getUserId() else {
            let myError = MyError(type: nil, message: nil)
            presenter?.interactor(didFailSaveProject: EditProject.SaveProjectAction.Response.Failure(myError: myError))
            return
        }
        userRepository.getUser(userId: userId) { [weak self] result in
            switch result {
            case .success(let user):
                success(user)
            case .failure(let myError):
                self?.presenter?.interactor(didFailSaveProject: EditProject.SaveProjectAction.Response.Failure(myError: myError))
            }
        }
    }

    private func setCurrentProject() {
        guard let currentProject = currentProject else { return }
        projectsRepository.setProject(project: currentProject) { [weak self] result in
            switch result {
            case .success(_):
                self?.presenter?.interactor(didSucceedSaveProject: EditProject.SaveProjectAction.Response.Success())
            case .failure(let myError):
                self?.presenter?.interactor(didFailSaveProject: EditProject.SaveProjectAction.Response.Failure(myError: myError))
            }
        }
    }
}

extension EditProjectInteractor {
    func getProject(request: EditProject.GetProjectAction.Request) {
        guard let projectId = projectId else { return }
        projectsRepository.getProject(projectId: projectId) { [weak self] result in
            switch result {
            case .success(let project):
                self?.currentProject = project
                self?.presenter?.interactor(didSucceedGetProject: EditProject.GetProjectAction.Response.Success(project: project))
            case .failure(let myError):
                self?.presenter?.interactor(didFailGetProject: EditProject.GetProjectAction.Response.Failure(myError: myError))
            }
        }
    }
}
