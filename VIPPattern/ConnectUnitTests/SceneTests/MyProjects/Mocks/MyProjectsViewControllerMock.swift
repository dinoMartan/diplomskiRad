 //
//  MyProjectsViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 18.06.2022..
//

@testable import Connect

class MyProjectsViewControllerMock {
    var didSucceedGetMyProjectsCalled = false
    var didSucceedGetMyProjectsCounter = 0
    var didSucceedGetMyProjectsViewModel: MyProjects.GetMyProjectsAction.ViewModel.Success?

    var didFailGetMyProjectsCalled = false
    var didFailGetMyProjectsCounter = 0
    var didFailGetMyProjectsViewModel: MyProjects.GetMyProjectsAction.ViewModel.Failure?
}

extension MyProjectsViewControllerMock: MyProjectsPresenterOutput {
    func presenter(didSucceedGetMyProjects viewModel: MyProjects.GetMyProjectsAction.ViewModel.Success) {
        didSucceedGetMyProjectsCalled = true
        didSucceedGetMyProjectsCounter += 1
        didSucceedGetMyProjectsViewModel = viewModel
    }

    func presenter(didFailGetMyProjects viewModel: MyProjects.GetMyProjectsAction.ViewModel.Failure) {
        didFailGetMyProjectsCalled = true
        didFailGetMyProjectsCounter += 1
        didFailGetMyProjectsViewModel = viewModel
    }
}
