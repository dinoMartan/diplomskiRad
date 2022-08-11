 //
//  ProjectDetailsViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 19.06.2022..
//

@testable import Connect

class ProjectDetailsViewControllerMock {
    var didSucceedGetProjectDetailsCalled = false
    var didSucceedGetProjectDetailsCounter = 0
    var didSucceedGetProjectDetailsViewModel: ProjectDetails.GetProjectDetailsAction.ViewModel.Success?

    var didFailGetProjectDetailsCalled = false
    var didFailGetProjectDetailsCounter = 0
    var didFailGetProjectDetailsViewModel: ProjectDetails.GetProjectDetailsAction.ViewModel.Failure?
}

extension ProjectDetailsViewControllerMock: ProjectDetailsPresenterOutput {
    func presenter(didSucceedGetProjectDetails viewModel: ProjectDetails.GetProjectDetailsAction.ViewModel.Success) {
        didSucceedGetProjectDetailsCalled = true
        didSucceedGetProjectDetailsCounter += 1
        didSucceedGetProjectDetailsViewModel = viewModel
    }

    func presenter(didFailGetProjectDetails viewModel: ProjectDetails.GetProjectDetailsAction.ViewModel.Failure) {
        didFailGetProjectDetailsCalled = true
        didFailGetProjectDetailsCounter += 1
        didFailGetProjectDetailsViewModel = viewModel
    }

    func presenter(didSucceedCreateConversation viewModel: ProjectDetails.CreateConversationAction.ViewModel.Success) {
        //
    }

    func presenter(didFailCreateConversation viewModel: ProjectDetails.CreateConversationAction.ViewModel.Failure) {
        //
    }
}
