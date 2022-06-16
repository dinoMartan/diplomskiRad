 //
//  HomePresenter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func interactor(didSucceedGetAllProjects response: Home.GetAllProjectsAction.Response.Success)
    func interactor(didFailGetAllProjects response: Home.GetAllProjectsAction.Response.Failure)
}

class HomePresenter: HomePresenterProtocol {
    weak var viewController: HomePresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedGetAllProjects response: Home.GetAllProjectsAction.Response.Success) {
        let projects = getHomeGetAllProjectsActionViewModelProjectsFromProjects(response.projects)
        let viewModel = Home.GetAllProjectsAction.ViewModel.Success(projects: projects)
        viewController?.presenter(didSucceedGetAllProjects: viewModel)
    }

    private func getHomeGetAllProjectsActionViewModelProjectsFromProjects(_ projects: [Project]) -> [Home.GetAllProjectsAction.ViewModel.Project] {
        projects.map {
            Home.GetAllProjectsAction.ViewModel.Project(projectId: $0.id,
                                                        projectTitle: $0.title,
                                                        ownerUsername: $0.owner?.username,
                                                        ownerImage: $0.owner?.profileImage)
        }
    }

    func interactor(didFailGetAllProjects response: Home.GetAllProjectsAction.Response.Failure) {
        let viewModel = Home.GetAllProjectsAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailGetAllProjects: viewModel)
    }
}
