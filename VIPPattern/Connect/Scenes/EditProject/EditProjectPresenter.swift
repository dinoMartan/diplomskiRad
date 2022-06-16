 //
//  EditProjectPresenter.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

protocol EditProjectPresenterProtocol: AnyObject {
    func interactor(didSucceedGetProject response: EditProject.GetProjectAction.Response.Success)
    func interactor(didFailGetProject response: EditProject.GetProjectAction.Response.Failure)
    func interactor(didSucceedSaveProject response: EditProject.SaveProjectAction.Response.Success)
    func interactor(didFailSaveProject response: EditProject.SaveProjectAction.Response.Failure)
}

class EditProjectPresenter: EditProjectPresenterProtocol {
    weak var viewController: EditProjectPresenterOutput?

    deinit {
        print("deinit \(self)")
        
    }

    func interactor(didSucceedGetProject response: EditProject.GetProjectAction.Response.Success) {
        let project = response.project
        let viewModel = EditProject.GetProjectAction.ViewModel.Success(title: project.title,
                                                                       description: project.description,
                                                                       haveTags: project.haveTags,
                                                                       needTags: project.needTags)
        viewController?.presenter(didSucceedGetProject: viewModel)
    }

    func interactor(didFailGetProject response: EditProject.GetProjectAction.Response.Failure) {
        viewController?.presenter(didFailGetProject: EditProject.GetProjectAction.ViewModel.Failure(myError: response.myError))
    }

    func interactor(didSucceedSaveProject response: EditProject.SaveProjectAction.Response.Success) {
        viewController?.presenter(didSucceedSaveProject: EditProject.SaveProjectAction.ViewModel.Success())
    }

    func interactor(didFailSaveProject response: EditProject.SaveProjectAction.Response.Failure) {
        viewController?.presenter(didFailSaveProject: EditProject.SaveProjectAction.ViewModel.Failure(myError: response.myError))
    }
}
