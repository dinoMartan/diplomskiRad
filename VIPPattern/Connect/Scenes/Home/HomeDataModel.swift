//
//  HomeDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct Home {
    struct ResponseFailure {
        let myError: MyError
    }

    struct ViewModelFailure {
        let myError: MyError
    }
}

// MARK: 
extension Home {
    struct Action {
        struct Request {

        }

        struct ResponseSuccess {
            
        }

        struct ViewModelSuccess {
            
        }
    }
}
