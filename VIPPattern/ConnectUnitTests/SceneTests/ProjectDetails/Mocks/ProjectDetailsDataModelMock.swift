 //
//  ProjectDetailsDataModelMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 19.06.2022..
//

@testable import Connect

struct ProjectDetailsDataModelMock {
    private static let dataMock = DataMock()
    static let myError = MyError(type: .codableError,
                                         message: "This is message")
    let getProjectDetailsAction = ProjectDetailsDataModelMock.GetProjectDetailsAction()
}

extension ProjectDetailsDataModelMock {
    struct GetProjectDetailsAction {
        let request = ProjectDetails.GetProjectDetailsAction.Request()
        let responseSuccess = ProjectDetails.GetProjectDetailsAction.Response.Success(project: dataMock.getProject())
        let responseFailure = ProjectDetails.GetProjectDetailsAction.Response.Failure(myError: ProjectDetailsDataModelMock.myError)
        let viewModelSuccess = ProjectDetails.GetProjectDetailsAction.ViewModel.Success(projectTitle: dataMock.getProject().title ?? "",
                                                                                        ownerImage: dataMock.getProject().owner?.profileImage ?? "",
                                                                                        ownerName: (dataMock.getProject().owner?.firstName ?? "") + " " + (dataMock.getProject().owner?.lastName ?? ""),
                                                                                        ownerUsername: dataMock.getProject().owner?.username ?? "",
                                                                                        projectDescription: dataMock.getProject().description ?? "",
                                                                                        projectNeeds: dataMock.getProject().needTags?.joined(separator: ", ") ?? "",
                                                                                        projectHas: dataMock.getProject().haveTags?.joined(separator: ", ") ?? "")
        let viewModelFailure = ProjectDetails.GetProjectDetailsAction.ViewModel.Failure(myError: ProjectDetailsDataModelMock.myError)
    }
}
