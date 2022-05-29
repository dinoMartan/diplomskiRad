 //
//  EditProjectPresenter.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

protocol EditProjectPresenterProtocol: AnyObject {
    func interactor(didSucceedGetProject response: EditProject.GetProjectAction.ResponseSuccess)
    func interactor(didSucceedSaveProject response: EditProject.SaveProjectAction.ResponseSuccess)
    func interactor(didFail response: EditProject.ResponseFailure)
}

class EditProjectPresenter: EditProjectPresenterProtocol {
    weak var viewController: EditProjectPresenterOutput?

    deinit {
        print("deinit \(self)")
        
    }

    func interactor(didSucceedGetProject response: EditProject.GetProjectAction.ResponseSuccess) {
        let project = response.project
        let viewModel = EditProject.GetProjectAction.ViewModelSuccess(title: project.title,
                                                                      description: project.description,
                                                                      haveTags: project.haveTags,
                                                                      needTags: project.needTags)
        viewController?.presenter(didSucceedGetProject: viewModel)
    }

    func interactor(didSucceedSaveProject response: EditProject.SaveProjectAction.ResponseSuccess) {
        viewController?.presenter(didSucceedSaveProject: EditProject.SaveProjectAction.ViewModelSuccess())
    }

    func interactor(didFail response: EditProject.ResponseFailure) {
        viewController?.presenter(didFail: EditProject.ViewModelFailure(myError: response.myError))
    }
}
