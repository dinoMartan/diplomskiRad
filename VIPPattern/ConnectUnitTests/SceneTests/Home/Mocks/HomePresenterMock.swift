 //
//  HomePresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 17.06.2022..
//

@testable import Connect

class HomePresenterMock {
    var didSucceedGetAllProjectsCalled = false
    var didSucceedGetAllProjectsCounter = 0
    var didSucceedGetAllProjectsResponse: Home.GetAllProjectsAction.Response.Success?
 
    var didFailGetAllProjectsCalled = false
    var didFailGetAllProjectsCounter = 0
    var didFailGetAllProjectsResponse: Home.GetAllProjectsAction.Response.Failure?

    var didSucceedGetProjectsWithNeedCalled = false
    var didSucceedGetProjectsWithNeedCounter = 0
    var didSucceedGetProjectsWithNeedResponse: Home.GetProjectsWithNeed.Response.Success?

    var didFailGetProjectsWithNeedCalled = false
    var didFailGetProjectsWithNeedCounter = 0
    var didFailGetProjectsWithNeedResponse: Home.GetProjectsWithNeed.Response.Failure?
}

extension HomePresenterMock: HomePresenterProtocol {
    func interactor(didSucceedGetAllProjects response: Home.GetAllProjectsAction.Response.Success) {
        didSucceedGetAllProjectsCalled = true
        didSucceedGetAllProjectsCounter += 1
        didSucceedGetAllProjectsResponse = response
    }

    func interactor(didFailGetAllProjects response: Home.GetAllProjectsAction.Response.Failure) {
        didFailGetAllProjectsCalled = true
        didFailGetAllProjectsCounter += 1
        didFailGetAllProjectsResponse = response
    }

    func interactor(didSucceedGetProjectsWithNeed response: Home.GetProjectsWithNeed.Response.Success) {
        didSucceedGetProjectsWithNeedCalled = true
        didSucceedGetProjectsWithNeedCounter += 1
        didSucceedGetProjectsWithNeedResponse = response
    }

    func interactor(didFailGetProjectsWithNeed response: Home.GetProjectsWithNeed.Response.Failure) {
        didFailGetProjectsWithNeedCalled = true
        didFailGetProjectsWithNeedCounter += 1
        didFailGetProjectsWithNeedResponse = response
    }
}
