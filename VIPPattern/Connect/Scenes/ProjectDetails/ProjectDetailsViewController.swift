 //
//  ProjectDetailsViewController.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import UIKit

protocol ProjectDetailsPresenterOutput: AnyObject {
    func presenter(didSucceedGetProjectDetails viewModel: ProjectDetails.GetProjectDetailsAction.ViewModel.Success)
    func presenter(didFailGetProjectDetails viewModel: ProjectDetails.GetProjectDetailsAction.ViewModel.Failure)
}

class ProjectDetailsViewController: UIViewController {
    var projectDetailsView: ProjectDetailsView?
    var interactor: ProjectDetailsInteractorProtocol?
    var router: ProjectDetailsRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = projectDetailsView
        let request = ProjectDetails.GetProjectDetailsAction.Request()
        interactor?.getProjectDetails(request: request)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        router?.shouldClose()
    }

    deinit {
        print("deinit \(self)")
    }
}

extension ProjectDetailsViewController: ProjectDetailsPresenterOutput {
    func presenter(didSucceedGetProjectDetails viewModel: ProjectDetails.GetProjectDetailsAction.ViewModel.Success) {
        projectDetailsView?.projectTitle.text = viewModel.projectTitle
        projectDetailsView?.ownerImageView.setImageFromFireStore(viewModel.ownerImage)
        projectDetailsView?.ownerName.text = viewModel.ownerName
        projectDetailsView?.ownerUsername.text = viewModel.ownerUsername
        projectDetailsView?.projectDescriptionView.setupTextWith(viewModel.projectDescription)
        projectDetailsView?.needTagsView.setupTextWith(viewModel.projectNeeds)
        projectDetailsView?.haveTagsView.setupTextWith(viewModel.projectHas)
    }

    func presenter(didFailGetProjectDetails viewModel: ProjectDetails.GetProjectDetailsAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
