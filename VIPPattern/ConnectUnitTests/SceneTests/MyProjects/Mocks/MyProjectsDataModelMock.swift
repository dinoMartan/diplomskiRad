 //
//  MyProjectsDataModelMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 18.06.2022..
//

@testable import Connect
import Foundation

struct MyProjectsDataModelMock {
    private static let dataMock = DataMock()
    static let myError = MyError(type: .codableError,
                                         message: "This is message")
    private static let mProject = MyProjects.MProject(id: dataMock.projectId ?? "",
                                                      title: dataMock.projectTitle ?? "",
                                                      createdAt: dataMock.projectCreatedAt?.toString(.short) ?? "",
                                                      needTags: dataMock.projectNeedTags?.joined(separator: ", ") ?? "",
                                                      haveTags: dataMock.projectHaveTags?.joined(separator: ", ") ?? "")
    let getMyProjectsAction = MyProjectsDataModelMock.GetMyProjectsAction()
    let deleteProjectAction = MyProjectsDataModelMock.DeleteProjectAction()
}

extension MyProjectsDataModelMock {
    struct GetMyProjectsAction {
        let request = MyProjects.GetMyProjectsAction.Request()
        let responseSuccess = MyProjects.GetMyProjectsAction.Response.Success(projects: [dataMock.getProject()])
        let responseFailure = MyProjects.GetMyProjectsAction.Response.Failure(myError: myError)
        let viewModelSuccess = MyProjects.GetMyProjectsAction.ViewModel.Success(projects: [mProject])
        let viewModelFailure = MyProjects.GetMyProjectsAction.ViewModel.Failure(myError: myError)
    }

    struct DeleteProjectAction {
        let request = MyProjects.DeleteProjectAction.Request(projectId: "project id")
        let responseSuccess = MyProjects.DeleteProjectAction.Response.Success()
        let responseFailure = MyProjects.DeleteProjectAction.Response.Failure(myError: myError)
        let viewModelSuccess = MyProjects.DeleteProjectAction.ViewModel.Success()
        let viewModelFailure = MyProjects.DeleteProjectAction.ViewModel.Failure(myError: myError)
    }
}
