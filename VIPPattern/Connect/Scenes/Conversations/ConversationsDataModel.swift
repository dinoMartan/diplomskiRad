//
//  ConversationsDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct Conversations {
    struct ResponseFailure {
        let myError: MyError
    }

    struct ViewModelFailure {
        let myError: MyError
    }
}

// MARK:
extension Conversations {
    struct Action {
        struct Request {

        }

        struct ResponseSuccess {
            
        }

        struct ViewModelSuccess {
            
        }
    }
}
