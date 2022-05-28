 //
//  EditProjectViewController.swift
//  VIPPattern
//
//  Created by Dino Martan on 27.05.2022..
//

import UIKit

protocol EditProjectPresenterOutput: AnyObject {
}

class EditProjectViewController: UIViewController {
    var editProjectView: EditProjectView?
    var interactor: EditProjectInteractorProtocol?
    var router: EditProjectRouterProtocol?

    private var project: Project? {
        didSet {
            //
        }
    }

    override func loadView() {
        super.loadView()
        self.view = editProjectView
        setSaveButtonAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.getProject()
    }

    deinit {
        router?.shouldClose()
        print("deinit \(self)")
    }
}

extension EditProjectViewController {
    private func setSaveButtonAction() {
        editProjectView?.saveButtonAction = { [weak self] in
            self?.setProjectFromUI()
            self?.interactor?.saveProject(self?.project)
        }
    }

    private func setProjectFromUI() {
        if project == nil {
            project = Project()
        }
        project?.title = editProjectView?.titleTextField.text
        project?.createdAt = Date()
        project?.description = editProjectView?.descriptionTextView.text
        project?.haveTags = editProjectView?.haveTagsField.tags.map({ $0.text }) // TODO: add to class
        project?.needTags = editProjectView?.needTagsField.tags.map({ $0.text })
    }
}

extension EditProjectViewController: EditProjectPresenterOutput {
}
