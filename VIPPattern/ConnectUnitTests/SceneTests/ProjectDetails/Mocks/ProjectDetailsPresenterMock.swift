 //
//  ProjectDetailsPresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 19.06.2022..
//

@testable import Connect

class ProjectDetailsPresenterMock {
    var didSucceedGetProjectDetailsCalled = false
    var didSucceedGetProjectDetailsCounter = 0
    var didSucceedGetProjectDetailsResponse: ProjectDetails.GetProjectDetailsAction.Response.Success?

    var didFailGetProjectDetailsCalled = false
    var didFailGetProjectDetailsCounter = 0
    var didFailGetProjectDetailsResponse: ProjectDetails.GetProjectDetailsAction.Response.Failure?
}

extension ProjectDetailsPresenterMock: ProjectDetailsPresenterProtocol {
    func interactor(didSucceedGetProjectDetails response: ProjectDetails.GetProjectDetailsAction.Response.Success) {
        didSucceedGetProjectDetailsCalled = true
        didSucceedGetProjectDetailsCounter += 1
        didSucceedGetProjectDetailsResponse = response
    }

    func interactor(didFailGetProjectDetails response: ProjectDetails.GetProjectDetailsAction.Response.Failure) {
        didFailGetProjectDetailsCalled = true
        didFailGetProjectDetailsCounter += 1
        didFailGetProjectDetailsResponse = response
    }

    func interactor(didSucceedCreateConversation response: ProjectDetails.CreateConversationAction.Response.Success) {
        //
    }

    func interactor(didFailCreateConversation response: ProjectDetails.CreateConversationAction.Response.Failure) {
        //
    }
}
