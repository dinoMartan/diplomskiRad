//
//  EditProjectDataModel.swift
//  Connect
//
//  Created by Dino Martan on 29.05.2022..
//

import Foundation

struct EditProject {
    struct ResponseFailure {
        let myError: MyError
    }

    struct ViewModelFailure {
        let myError: MyError
    }
}

// MARK: GetProjectAction
extension EditProject {
    struct GetProjectAction {
        struct Request {
        }

        struct ResponseSuccess {
            let project: Project
        }

        struct ViewModelSuccess {
            let title: String?
            let description: String?
            let haveTags: [String]?
            let needTags: [String]?
        }
    }
}

// MARK: SaveProjectAction
extension EditProject {
    struct SaveProjectAction {
        struct Request {
            let title: String?
            let description: String?
            let haveTags: [String]?
            let needTags: [String]?
        }

        struct ResponseSuccess {
        }

        struct ViewModelSuccess {
            
        }
    }
}
