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
    func interactor(didSucceedGetProjectsWithNeed response: Home.GetProjectsWithNeed.Response.Success)
    func interactor(didFailGetProjectsWithNeed response: Home.GetProjectsWithNeed.Response.Failure)
}

class HomePresenter: HomePresenterProtocol {
    weak var viewController: HomePresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedGetAllProjects response: Home.GetAllProjectsAction.Response.Success) {
        let projects = getHomeProjectsFromProjects(response.projects)
        let viewModel = Home.GetAllProjectsAction.ViewModel.Success(projects: projects)
        viewController?.presenter(didSucceedGetAllProjects: viewModel)
    }

    func interactor(didFailGetAllProjects response: Home.GetAllProjectsAction.Response.Failure) {
        let viewModel = Home.GetAllProjectsAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailGetAllProjects: viewModel)
    }

    func interactor(didSucceedGetProjectsWithNeed response: Home.GetProjectsWithNeed.Response.Success) {
        let projects = getHomeProjectsFromProjects(response.projects)
        let viewModel = Home.GetProjectsWithNeed.ViewModel.Success(projects: projects)
        viewController?.presenter(didSucceedGetProjectsWithNeed: viewModel)
    }

    func interactor(didFailGetProjectsWithNeed response: Home.GetProjectsWithNeed.Response.Failure) {
        let viewModel = Home.GetProjectsWithNeed.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailGetProjectsWithNeed: viewModel)
    }

    private func getHomeProjectsFromProjects(_ projects: [Project]) -> [Home.HProject] {
        projects.map {
            Home.HProject(projectId: $0.id,
                          projectTitle: $0.title,
                          ownerUsername: $0.owner?.username,
                          ownerImage: $0.owner?.profileImage,
                          projectNeeds: $0.needTags?.joined(separator: ",") ?? "")
        }
    }
}
