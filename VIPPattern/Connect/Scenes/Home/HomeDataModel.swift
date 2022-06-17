//
//  HomeDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct Home: Equatable {
    struct HProject: Equatable {
        let projectId: String?
        let projectTitle: String?
        let ownerUsername: String?
        let ownerImage: String?
        let projectNeeds: String
    }
}

// MARK: GetAllProjectsAction
extension Home {
    struct GetAllProjectsAction: Equatable {
        struct Request: Equatable { }

        struct Response: Equatable {
            struct Success: Equatable {
                let projects: [Project]
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable {
                let projects: [Home.HProject]
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}
