 //
//  HomeDataModelMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 17.06.2022..
//

@testable import Connect

struct HomeDataModelMock {
    private static let dataMock = DataMock()
    static let myError = MyError(type: .codableError,
                                         message: "This is message")
    let getAllProjectsAction = HomeDataModelMock.GetAllProjectsAction()
    let getProjectsWithNeedAction = HomeDataModelMock.GetProjectsWithNeed()
}

extension HomeDataModelMock {
    struct GetAllProjectsAction {
        let request = Home.GetAllProjectsAction.Request()
        let responseSuccess = Home.GetAllProjectsAction.Response.Success(projects: [dataMock.getProject()])
        let responseFailure = Home.GetAllProjectsAction.Response.Failure(myError: myError)
        let viewModelSuccess = Home.GetAllProjectsAction.ViewModel.Success(projects: [Home.HProject(projectId: dataMock.getProject().id,
                                                                                                    projectTitle: dataMock.getProject().title,
                                                                                                    ownerUsername: dataMock.getProject().owner?.username,
                                                                                                    ownerImage: dataMock.getProject().owner?.profileImage,
                                                                                                    projectNeeds: dataMock.getProject().needTags?.joined(separator: ",") ?? "")])
        let viewModelFailure = Home.GetAllProjectsAction.ViewModel.Failure(myError: myError)
    }
}

extension HomeDataModelMock {
    struct GetProjectsWithNeed {
        let request = Home.GetProjectsWithNeed.Request(need: "need test")
        let responseSuccess = Home.GetProjectsWithNeed.Response.Success(projects: [dataMock.getProject()])
        let responseFailure = Home.GetProjectsWithNeed.Response.Failure(myError: myError)
        let viewModelSuccess = Home.GetProjectsWithNeed.ViewModel.Success(projects: [Home.HProject(projectId: dataMock.getProject().id,
                                                                                                    projectTitle: dataMock.getProject().title,
                                                                                                    ownerUsername: dataMock.getProject().owner?.username,
                                                                                                    ownerImage: dataMock.getProject().owner?.profileImage,
                                                                                                    projectNeeds: dataMock.getProject().needTags?.joined(separator: ",") ?? "")])
        let viewModelFailure = Home.GetProjectsWithNeed.ViewModel.Failure(myError: myError)
    }
}
