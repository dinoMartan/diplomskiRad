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
        struct Request: Equatable { }

        struct Response: Equatable {
            struct Success {
                let project: Project
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable {
                let projectTitle: String
                let ownerImage: String
                let ownerName: String
                let ownerUsername: String
                let projectDescription: String
                let projectNeeds: String
                let projectHas: String
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}
