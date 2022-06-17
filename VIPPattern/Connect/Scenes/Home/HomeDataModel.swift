//
//  HomeDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct Home {
    struct HProject {
        let projectId: String?
        let projectTitle: String?
        let ownerUsername: String?
        let ownerImage: String?
        let projectNeeds: String
    }
}

// MARK: GetAllProjectsAction
extension Home {
    struct GetAllProjectsAction {
        struct Request { }

        struct Response {
            struct Success {
                let projects: [Project]
            }

            struct Failure {
                let myError: MyError
            }
        }

        struct ViewModel {
            struct Success {
                let projects: [Home.HProject]
            }

            struct Failure {
                let myError: MyError
            }
        }
    }
}
