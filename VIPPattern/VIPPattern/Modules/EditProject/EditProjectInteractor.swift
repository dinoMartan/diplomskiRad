 //
//  EditProjectInteractor.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import Foundation

protocol EditProjectInteractorProtocol {
}

class EditProjectInteractor: EditProjectInteractorProtocol {
    var presenter: EditProjectPresenterProtocol?

    private let project: Project?

    init(project: Project?) {
        self.project = project
    }

    deinit {
        print("deinit \(self)")
    }
}

extension EditProjectInteractor {
}
