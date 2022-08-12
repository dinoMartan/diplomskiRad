 //
//  ConversationDetailsDataModelMock.swift
//  ConnectUnitTests
//
//  Created by Dino Martan on 12.08.2022..
//

@testable import Connect

struct ConversationDetailsDataModelMock {
    static let dataMock = DataMock()
    static let myError = MyError(type: .codableError,
                                         message: "This is message")
    let getConversationAction = ConversationDetailsDataModelMock.GetConversationAction()
    let sendMessageAction = ConversationDetailsDataModelMock.SendMessageAction()
}

extension ConversationDetailsDataModelMock {
    struct GetConversationAction {
        let request = ConversationDetails.GetConversationAction.Request()
        let responseSuccess = ConversationDetails.GetConversationAction.Response.Success(currentUserId: dataMock.userId ?? "",
                                                                                         conversation: dataMock.getConversation())
        let responseFailure = ConversationDetails.GetConversationAction.Response.Failure(myError: myError)
        let viewModelSuccess = ConversationDetails.GetConversationAction.ViewModel.Success(pojectTitle: dataMock.projectTitle ?? "",
                                                                                           messages: [ConversationDetails.CDMessage(value: dataMock.messageValue ?? "",
                                                                                                                                    isCurrentUsersMessage: false,
                                                                                                                                    image: dataMock.userProfileImage ?? "")])
        let viewModelFailure = ConversationDetails.GetConversationAction.ViewModel.Failure(myError: myError)
    }
}

extension ConversationDetailsDataModelMock {
    struct SendMessageAction {
        let request = ConversationDetails.SendMessageAction.Request(message: "new message")
        let responseSuccess = ConversationDetails.SendMessageAction.Response.Success()
        let responseFailure = ConversationDetails.SendMessageAction.Response.Failure(myError: myError)
        let viewModelSuccess = ConversationDetails.SendMessageAction.ViewModel.Success()
        let viewModelFailure = ConversationDetails.SendMessageAction.ViewModel.Failure(myError: myError)
        
    }
}
