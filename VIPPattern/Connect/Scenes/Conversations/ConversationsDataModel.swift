//
//  ConversationsDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct Conversations: Equatable {
    struct CConversation: Equatable {
        let id: String?
        let image: String?
        let name: String?
        let lastMessage: String?
    }
}

// MARK: GetUsersConversationsAction
extension Conversations {
    struct GetUsersConversationsAction: Equatable {
        struct Request: Equatable { }

        struct Response: Equatable {
            struct Success: Equatable {
                let currentUserId: String
                let conversations: [Conversation]
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable {
                let conversations: [CConversation]
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}
