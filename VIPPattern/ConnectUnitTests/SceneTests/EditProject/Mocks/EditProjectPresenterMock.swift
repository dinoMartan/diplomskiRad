 //
//  EditProjectPresenterMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect

class EditProjectPresenterMock {
    var didSucceedGetProjectCalled = false
    var didSucceedGetProjectCounter = 0
    var didSucceedGetProjectResponse: EditProject.GetProjectAction.Response.Success?

    var didFailGetProjectCalled = false
    var didFailGetProjectCounter = 0
    var didFailGetProjectResponse: EditProject.GetProjectAction.Response.Failure?

    var didSucceedSaveProjectCalled = false
    var didSucceedSaveProjectCounter = 0
    var didSucceedSaveProjectResponse: EditProject.SaveProjectAction.Response.Success?

    var didFailSaveProjectCalled = false
    var didFailSaveProjectCounter = 0
    var didFailSaveProjectResponse: EditProject.SaveProjectAction.Response.Failure?
}

extension EditProjectPresenterMock: EditProjectPresenterProtocol {
    func interactor(didSucceedGetProject response: EditProject.GetProjectAction.Response.Success) {
        didSucceedGetProjectCalled = true
        didSucceedGetProjectCounter += 1
        didSucceedGetProjectResponse = response
    }

    func interactor(didFailGetProject response: EditProject.GetProjectAction.Response.Failure) {
        didFailGetProjectCalled = true
        didFailGetProjectCounter += 1
        didFailGetProjectResponse = response
    }

    func interactor(didSucceedSaveProject response: EditProject.SaveProjectAction.Response.Success) {
        didSucceedSaveProjectCalled = true
        didSucceedSaveProjectCounter += 1
        didSucceedSaveProjectResponse = response
    }

    func interactor(didFailSaveProject response: EditProject.SaveProjectAction.Response.Failure) {
        didFailSaveProjectCalled = true
        didFailSaveProjectCounter += 1
        didFailSaveProjectResponse = response
    }
}
