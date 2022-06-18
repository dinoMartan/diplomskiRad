 //
//  ProjectDetailsDataModel.swift
//  Connect
//
//  Created by Dino Martan on 18.06.2022..
//

import Foundation

struct ProjectDetails: Equatable { }

extension ProjectDetails {
    struct GetProjectDetailsAction: Equatable {
        struct Request: Equatable {
            let projectId: String
        }

        struct Response: Equatable {
            struct Success { }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable {
                let title: String
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}
