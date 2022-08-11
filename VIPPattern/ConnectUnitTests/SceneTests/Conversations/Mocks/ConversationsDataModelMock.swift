 //
//  ConversationsDataModelMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 11.08.2022..
//

@testable import Connect

struct ConversationsDataModelMock {
    static let dataMock = DataMock()
    static let myError = MyError(type: .codableError,
                                         message: "This is message")
    let getUsersConversationsAction = ConversationsDataModelMock.GetUsersConversationsAction()
}

extension ConversationsDataModelMock {
    struct GetUsersConversationsAction {
        let request = Conversations.GetUsersConversationsAction.Request()
        let responseSuccess = Conversations.GetUsersConversationsAction.Response.Success(currentUserId: dataMock.userId ?? "",
                                                                                         conversations: [Conversation(id: "conv id",
                                                                                                                      project: dataMock.getProject().getProjectNested(),
                                                                                                                      users: [dataMock.getUser().getUserNested(),
                                                                                                                             UserNested(id: "different user",
                                                                                                                                        username: "some",
                                                                                                                                        firstName: "user",
                                                                                                                                        lastName: "last name",
                                                                                                                                        email: "email",
                                                                                                                                        profileImage: "image")],
                                                                                                                      userIds: [dataMock.userId ?? "", "different user"],
                                                                                                                      createdAt: DataMock.date,
                                                                                                                      messages: [dataMock.getMessage()])])
        let responseFailure = Conversations.GetUsersConversationsAction.Response.Failure(myError: myError)
        let viewModelSuccess = Conversations.GetUsersConversationsAction.ViewModel.Success(conversations: [Conversations.CConversation(image: "image",
                                                                                                                                       name: "user",
                                                                                                                                       lastMessage: dataMock.messageValue)])
        let viewModelFailure = Conversations.GetUsersConversationsAction.ViewModel.Failure(myError: myError)
    }
}
