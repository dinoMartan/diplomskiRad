 //
//  HomeViewControllerMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 17.06.2022..
//

@testable import Connect

class HomeViewControllerMock {
    var didSucceedGetAllProjectsCalled = false
    var didSucceedGetAllProjectsCounter = 0
    var didSucceedGetAllProjectsViewModel: Home.GetAllProjectsAction.ViewModel.Success?
 
    var didFailGetAllProjectsCalled = false
    var didFailGetAllProjectsCounter = 0
    var didFailGetAllProjectsViewModel: Home.GetAllProjectsAction.ViewModel.Failure?

    var didSucceedGetProjectsWithNeedCalled = false
    var didSucceedGetProjectsWithNeedCounter = 0
    var didSucceedGetProjectsWithNeedViewModel: Home.GetProjectsWithNeed.ViewModel.Success?

    var didFailGetProjectsWithNeedCalled = false
    var didFailGetProjectsWithNeedCounter = 0
    var didFailGetProjectsWithNeedViewModel: Home.GetProjectsWithNeed.ViewModel.Failure?
}

extension HomeViewControllerMock: HomePresenterOutput {
    func presenter(didSucceedGetAllProjects viewModel: Home.GetAllProjectsAction.ViewModel.Success) {
        didSucceedGetAllProjectsCalled = true
        didSucceedGetAllProjectsCounter += 1
        didSucceedGetAllProjectsViewModel = viewModel
    }

    func presenter(didFailGetAllProjects viewModel: Home.GetAllProjectsAction.ViewModel.Failure) {
        didFailGetAllProjectsCalled = true
        didFailGetAllProjectsCounter += 1
        didFailGetAllProjectsViewModel = viewModel
    }

    func presenter(didSucceedGetProjectsWithNeed viewModel: Home.GetProjectsWithNeed.ViewModel.Success) {
        didSucceedGetProjectsWithNeedCalled = true
        didSucceedGetProjectsWithNeedCounter += 1
        didSucceedGetProjectsWithNeedViewModel = viewModel
    }

    func presenter(didFailGetProjectsWithNeed viewModel: Home.GetProjectsWithNeed.ViewModel.Failure) {
        didFailGetProjectsWithNeedCalled = true
        didFailGetProjectsWithNeedCounter += 1
        didFailGetProjectsWithNeedViewModel = viewModel
    }
}
