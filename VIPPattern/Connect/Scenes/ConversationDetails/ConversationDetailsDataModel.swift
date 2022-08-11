 //
//  ConversationDetailsDataModel.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

struct ConversationDetails: Equatable {
    struct CDMessage: Equatable {
        let value: String
        let isCurrentUsersMessage: Bool?
    }
}

extension ConversationDetails {
    struct GetConversationAction: Equatable {
        struct Request: Equatable { }

        struct Response: Equatable {
            struct Success: Equatable {
                let currentUserId: String
                let conversation: Conversation
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable {
                let pojectTitle: String
                let messages: [ConversationDetails.CDMessage]
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}
