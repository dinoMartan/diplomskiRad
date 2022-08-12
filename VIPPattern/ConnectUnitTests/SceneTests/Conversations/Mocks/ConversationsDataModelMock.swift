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
                                                                                         conversations: [dataMock.getConversation()])
        let responseFailure = Conversations.GetUsersConversationsAction.Response.Failure(myError: myError)
        let viewModelSuccess = Conversations.GetUsersConversationsAction.ViewModel.Success(conversations: [Conversations.CConversation(id: dataMock.conversationId,
                                                                                                                                       image: dataMock.conversationUserProfileImage,
                                                                                                                                       name: dataMock.conversationUserFirstName,
                                                                                                                                       lastMessage: dataMock.messageValue)])
        let viewModelFailure = Conversations.GetUsersConversationsAction.ViewModel.Failure(myError: myError)
    }
}
