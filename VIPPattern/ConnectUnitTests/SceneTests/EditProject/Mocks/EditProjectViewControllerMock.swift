 //
//  EditProjectViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect

class EditProjectViewControllerMock {
    var didSucceedGetProjectCalled = false
    var didSucceedGetProjectCounter = 0
    var didSucceedGetProjectViewModel: EditProject.GetProjectAction.ViewModel.Success?

    var didFailGetProjectCalled = false
    var didFailGetProjectCounter = 0
    var didFailGetProjectViewModel: EditProject.GetProjectAction.ViewModel.Failure?

    var didSucceedSaveProjectCalled = false
    var didSucceedSaveProjectCounter = 0
    var didSucceedSaveProjectViewModel: EditProject.SaveProjectAction.ViewModel.Success?

    var didFailSaveProjectCalled = false
    var didFailSaveProjectCounter = 0
    var didFailSaveProjectViewModel: EditProject.SaveProjectAction.ViewModel.Failure?
}

extension EditProjectViewControllerMock: EditProjectPresenterOutput {
    func presenter(didSucceedGetProject viewModel: EditProject.GetProjectAction.ViewModel.Success) {
        didSucceedGetProjectCalled = true
        didSucceedGetProjectCounter += 1
        didSucceedGetProjectViewModel = viewModel
    }

    func presenter(didFailGetProject viewModel: EditProject.GetProjectAction.ViewModel.Failure) {
        didFailGetProjectCalled = true
        didFailGetProjectCounter += 1
        didFailGetProjectViewModel = viewModel
    }

    func presenter(didSucceedSaveProject viewModel: EditProject.SaveProjectAction.ViewModel.Success) {
        didSucceedSaveProjectCalled = true
        didSucceedSaveProjectCounter += 1
        didSucceedSaveProjectViewModel = viewModel
    }

    func presenter(didFailSaveProject viewModel: EditProject.SaveProjectAction.ViewModel.Failure) {
        didFailSaveProjectCalled = true
        didFailSaveProjectCounter += 1
        didFailSaveProjectViewModel = viewModel
    }
}
