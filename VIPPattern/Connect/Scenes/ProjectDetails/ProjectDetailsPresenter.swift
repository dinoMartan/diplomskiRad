 //
//  ProjectDetailsPresenter.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

protocol ProjectDetailsPresenterProtocol: AnyObject {
    func interactor(didSucceedGetProjectDetails response: ProjectDetails.GetProjectDetailsAction.Response.Success)
    func interactor(didFailGetProjectDetails response: ProjectDetails.GetProjectDetailsAction.Response.Failure)
}

class ProjectDetailsPresenter: ProjectDetailsPresenterProtocol {
    weak var viewController: ProjectDetailsPresenterOutput?

    deinit {
        print("deinit \(self)")
    }

    func interactor(didSucceedGetProjectDetails response: ProjectDetails.GetProjectDetailsAction.Response.Success) {
        let viewModel = ProjectDetails.GetProjectDetailsAction.ViewModel.Success(projectTitle: response.project.title ?? "",
                                                                                 ownerImage: response.project.owner?.profileImage ?? "",
                                                                                 ownerName: (response.project.owner?.firstName ?? "") + " " + (response.project.owner?.lastName ?? ""),
                                                                                 ownerUsername: response.project.owner?.username ?? "",
                                                                                 projectDescription: response.project.description ?? "",
                                                                                 projectNeeds: response.project.needTags?.joined(separator: ", ") ?? "",
                                                                                 projectHas: response.project.haveTags?.joined(separator: ", ") ?? "")
        viewController?.presenter(didSucceedGetProjectDetails: viewModel)
    }

    func interactor(didFailGetProjectDetails response: ProjectDetails.GetProjectDetailsAction.Response.Failure) {
        let viewModel = ProjectDetails.GetProjectDetailsAction.ViewModel.Failure(myError: response.myError)
        viewController?.presenter(didFailGetProjectDetails: viewModel)
    }
}
