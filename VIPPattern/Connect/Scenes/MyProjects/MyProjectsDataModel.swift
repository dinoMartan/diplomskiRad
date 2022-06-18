//
//  MyProjectsDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct MyProjects: Equatable {
    struct MProject: Equatable {
        let id: String?
        let title: String
        let createdAt: String
        let needTags: String
        let haveTags: String
    }
}

// MARK: GetMyProjectsAction
extension MyProjects {
    struct GetMyProjectsAction: Equatable {
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
                let projects: [MyProjects.MProject]
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}

// MARK: DeleteProjectAction
extension MyProjects {
    struct DeleteProjectAction: Equatable {
        struct Request: Equatable {
            let projectId: String
        }

        struct Response: Equatable {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}
