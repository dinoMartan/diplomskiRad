 //
//  EditProjectDataModelMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 16.06.2022..
//

@testable import Connect

struct EditProjectDataModelMock {
    private static let dataMock = DataMock()
    static let myError = MyError(type: .codableError,
                                         message: "This is message")
    let getProjectAction = EditProjectDataModelMock.GetProjectAction()
    let saveProjectAction = EditProjectDataModelMock.SaveProjectAction()
}

extension EditProjectDataModelMock {
    struct GetProjectAction {
        let request = EditProject.GetProjectAction.Request()
        let responseSuccess = EditProject.GetProjectAction.Response.Success(project: dataMock.getProject())
        let responseFailure = EditProject.GetProjectAction.Response.Failure(myError: myError)
        let viewModelSuccess = EditProject.GetProjectAction.ViewModel.Success(title: dataMock.getProject().title,
                                                                              description: dataMock.getProject().description,
                                                                              haveTags: dataMock.getProject().haveTags,
                                                                              needTags: dataMock.getProject().needTags)
        let viewModelFailure = EditProject.GetProjectAction.ViewModel.Failure(myError: myError)
    }
}

extension EditProjectDataModelMock {
    struct SaveProjectAction {
        let request = EditProject.SaveProjectAction.Request(title: "title",
                                                            description: "description",
                                                            haveTags: ["have tag"],
                                                            needTags: ["need tag"])
        let responseSuccess = EditProject.SaveProjectAction.Response.Success()
        var responseFailure = EditProject.SaveProjectAction.Response.Failure(myError: myError)
        let viewModelSuccess = EditProject.SaveProjectAction.ViewModel.Success()
        let viewModelFailure = EditProject.SaveProjectAction.ViewModel.Failure(myError: myError)
    }
}
