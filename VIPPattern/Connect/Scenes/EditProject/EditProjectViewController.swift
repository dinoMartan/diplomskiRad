 //
//  EditProjectViewController.swift
//  Connect
//
//  Created by Dino Martan on 27.05.2022..
//

import UIKit

protocol EditProjectPresenterOutput: AnyObject {
    func presenter(didSucceedGetProject viewModel: EditProject.GetProjectAction.ViewModelSuccess)
    func presenter(didSucceedSaveProject viewModel: EditProject.SaveProjectAction.ViewModelSuccess)
    func presenter(didFail viewModel: EditProject.ViewModelFailure)
}

class EditProjectViewController: UIViewController {
    var editProjectView: EditProjectView?
    var interactor: EditProjectInteractorProtocol?
    var router: EditProjectRouterProtocol?

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
        interactor?.getProject(request: EditProject.GetProjectAction.Request())
    }

    deinit {
        router?.shouldClose()
        print("deinit \(self)")
    }
}

extension EditProjectViewController {
    private func setSaveButtonAction() {
        editProjectView?.saveButtonAction = { [weak self] in
            guard let request = self?.getSaveProjectActionRequest() else { return }
            self?.interactor?.saveProject(request: request)
        }
    }

    private func getSaveProjectActionRequest() -> EditProject.SaveProjectAction.Request {
        EditProject.SaveProjectAction.Request(title: editProjectView?.titleTextField.text,
                                              description: editProjectView?.descriptionTextView.text,
                                              haveTags: editProjectView?.haveTagsField.getTags(),
                                              needTags: editProjectView?.needTagsField.getTags())
    }
}

extension EditProjectViewController: EditProjectPresenterOutput {
    func presenter(didSucceedGetProject viewModel: EditProject.GetProjectAction.ViewModelSuccess) {
        editProjectView?.titleTextField.text = viewModel.title
        editProjectView?.descriptionTextView.text = viewModel.description
        editProjectView?.haveTagsField.addTags(viewModel.haveTags ?? [])
        editProjectView?.needTagsField.addTags(viewModel.needTags ?? [])
    }

    func presenter(didSucceedSaveProject viewModel: EditProject.SaveProjectAction.ViewModelSuccess) {
        navigationController?.popViewController(animated: true)
    }

    func presenter(didFail viewModel: EditProject.ViewModelFailure) {
        showMyErrorAlert(viewModel.myError)
    }
}
