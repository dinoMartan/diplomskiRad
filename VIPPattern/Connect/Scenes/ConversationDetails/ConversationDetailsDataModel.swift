 //
//  ConversationDetailsDataModel.swift
//  Connect
//
//  Created by Dino Martan on 19.06.2022..
//

import Foundation

struct ConversationDetails: Equatable {
}

extension ConversationDetails {
    struct GetConversationAction: Equatable {
        struct Request: Equatable { }

        struct Response: Equatable {
            struct Success: Equatable {
                let conversation: Conversation
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable {
                
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}
