 //
//  MyProjectsPresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 18.06.2022..
//

@testable import Connect

class MyProjectsPresenterMock {
    var didSucceedGetMyProjectsCalled = false
    var didSucceedGetMyProjectsCounter = 0
    var didSucceedGetMyProjectsResponse: MyProjects.GetMyProjectsAction.Response.Success?

    var didFailGetMyProjectsCalled = false
    var didFailGetMyProjectsCounter = 0
    var didFailGetMyProjectsResponse: MyProjects.GetMyProjectsAction.Response.Failure?
}

extension MyProjectsPresenterMock: MyProjectsPresenterProtocol {
    func interactor(didSucceedGetMyProjects response: MyProjects.GetMyProjectsAction.Response.Success) {
        didSucceedGetMyProjectsCalled = true
        didSucceedGetMyProjectsCounter += 1
        didSucceedGetMyProjectsResponse = response
    }

    func interactor(didFailGetMyProjects response: MyProjects.GetMyProjectsAction.Response.Failure) {
        didFailGetMyProjectsCalled = true
        didFailGetMyProjectsCounter += 1
        didFailGetMyProjectsResponse = response
    }
}
