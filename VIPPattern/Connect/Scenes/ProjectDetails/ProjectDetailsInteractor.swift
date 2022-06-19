 //
//  ProjectDetailsInteractor.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

protocol ProjectDetailsInteractorProtocol {
    func getProjectDetails(request: ProjectDetails.GetProjectDetailsAction.Request)
    func createConversation(request: ProjectDetails.CreateConversationAction.Request)
}

class ProjectDetailsInteractor: ProjectDetailsInteractorProtocol {
    var presenter: ProjectDetailsPresenterProtocol?

    private let projectsRepository: ProjectsRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let keychainService: KeychainServiceProtocol
    private let conversationsRepository: ConversationsRepositoryProtocol

    private let projectId: String
    private var project: Project?

    init(projectsRepository: ProjectsRepositoryProtocol,
         userRepository: UserRepositoryProtocol,
         keychainService: KeychainServiceProtocol,
         conversationsRepository: ConversationsRepositoryProtocol,
         projectId: String) {
        self.projectsRepository = projectsRepository
        self.userRepository = userRepository
        self.keychainService = keychainService
        self.conversationsRepository = conversationsRepository
        self.projectId = projectId
    }

    deinit {
        print("deinit \(self)")
    }
}

// MARK: GetProjectDetailsAction
extension ProjectDetailsInteractor {
    func getProjectDetails(request: ProjectDetails.GetProjectDetailsAction.Request) {
        projectsRepository.getProject(projectId: projectId) { [weak self] result in
            switch result {
            case .success(let project):
                self?.project = project
                let response = ProjectDetails.GetProjectDetailsAction.Response.Success(project: project)
                self?.presenter?.interactor(didSucceedGetProjectDetails: response)
            case .failure(let myError):
                let response = ProjectDetails.GetProjectDetailsAction.Response.Failure(myError: myError)
                self?.presenter?.interactor(didFailGetProjectDetails: response)
            }
        }
    }
}

// MARK: CreateConversationAction
extension ProjectDetailsInteractor {
    func createConversation(request: ProjectDetails.CreateConversationAction.Request) {
        guard let project = project else { return }
        getUserDetails { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                let conversation = self.createConversationFrom(currentUser: user, project: project)
                self.conversationsRepository.setConversation(conversation, completion: self.handleCreateConversationSuccess(_:))
            case .failure(let myError):
                let response = ProjectDetails.CreateConversationAction.Response.Failure(myError: myError)
                self.presenter?.interactor(didFailCreateConversation: response)
            }
        }
    }

    private func handleCreateConversationSuccess(_ result: Result<String, MyError>) {
        switch result {
        case .success(let conversationId):
            let response = ProjectDetails.CreateConversationAction.Response.Success(conversationId: conversationId)
            presenter?.interactor(didSucceedCreateConversation: response)
        case .failure(let myError):
            let response = ProjectDetails.CreateConversationAction.Response.Failure(myError: myError)
            presenter?.interactor(didFailCreateConversation: response)
        }
    }

    private func getUserDetails(completion: @escaping ((Result<User, MyError>) -> Void)) {
        guard let userId = keychainService.getUserId() else { return }
        userRepository.getUser(userId: userId, completion: completion)
    }

    private func createConversationFrom(currentUser: User, project: Project) -> Conversation {
        let conversationId = UUID().uuidString
        return Conversation(id: conversationId,
                            project: project.getProjectNested(),
                            users: [currentUser.getUserNested(), project.owner].compactMap({$0}),
                            userIds: [currentUser.id ?? "", project.owner?.id ?? ""],
                            createdAt: Date(),
                            messages: [])
    }
}
