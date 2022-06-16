//
//  EditProjectDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct EditProject: Equatable { }

// MARK: GetProjectAction
extension EditProject {
    struct GetProjectAction: Equatable {
        struct Request: Equatable { }

        struct Response: Equatable {
            struct Success: Equatable {
                let project: Project
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel: Equatable {
            struct Success: Equatable {
                let title: String?
                let description: String?
                let haveTags: [String]?
                let needTags: [String]?
            }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}

// MARK: SaveProjectAction
extension EditProject {
    struct SaveProjectAction: Equatable {
        struct Request: Equatable {
            let title: String?
            let description: String?
            let haveTags: [String]?
            let needTags: [String]?
        }

        struct Response: Equatable {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError
            }
        }

        struct ViewModel {
            struct Success: Equatable { }

            struct Failure: Equatable {
                let myError: MyError
            }
        }
    }
}
