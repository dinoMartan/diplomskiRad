//
//  MyProjectsDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct MyProjects {
    struct ResponseFailure {
        let myError: MyError
    }

    struct ViewModelFailure {
        let myError: MyError
    }
}

// MARK:
extension MyProjects {
    struct Action {
        struct Request {

        }

        struct ResponseSuccess {
            
        }

        struct ViewModelSuccess {
            
        }
    }
}
