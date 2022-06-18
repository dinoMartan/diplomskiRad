 //
//  MyProjectsPresenter.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import Foundation

protocol MyProjectsPresenterProtocol: AnyObject {
    func interactor(didSucceedGetMyProjects response: MyProjects.GetMyProjectsAction.Response.Success)
    func interactor(didFailGetMyProjects response: MyProjects.GetMyProjectsAction.Response.Failure)
    func interactor(didSucceedDeleteProject response: MyProjects.DeleteProjectAction.Response.Success)
    func interactor(didFailDeleteProject response: MyProjects.DeleteProjectAction.Response.Failure)
}

class MyProjectsPresenter: MyProjectsPresenterProtocol {
    weak var viewController: MyProjectsPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedGetMyProjects response: MyProjects.GetMyProjectsAction.Response.Success) {
        let projects = getMyProjectsMProjectsFromProjects(response.projects)
        let viewModel = MyProjects.GetMyProjectsAction.ViewModel.Success(projects: projects)
        viewController?.presenter(didSucceedGetMyProjects: viewModel)
    }

    private func getMyProjectsMProjectsFromProjects(_ projects: [Project]) -> [MyProjects.MProject] {
        projects.map {
            MyProjects.MProject(id: $0.id,
                                title: $0.title ?? "",
                                createdAt: $0.createdAt?.toString(.short) ?? "",
                                needTags: $0.needTags?.joined(separator: ", ") ?? "",
                                haveTags: $0.haveTags?.joined(separator: ", ") ?? "")
        }
    }

    func interactor(didFailGetMyProjects response: MyProjects.GetMyProjectsAction.Response.Failure) {
        let viewModel = MyProjects.GetMyProjectsAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailGetMyProjects: viewModel)
    }

    func interactor(didSucceedDeleteProject response: MyProjects.DeleteProjectAction.Response.Success) {
        let viewModel = MyProjects.DeleteProjectAction.ViewModel.Success()
        viewController?.presenter(didSucceedDeleteProject: viewModel)
    }

    func interactor(didFailDeleteProject response: MyProjects.DeleteProjectAction.Response.Failure) {
        let viewModel = MyProjects.DeleteProjectAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailDeleteProject: viewModel)
    }
}
