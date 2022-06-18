 //
//  MyProjectsViewController.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol MyProjectsPresenterOutput: AnyObject {
    func presenter(didSucceedGetMyProjects viewModel: MyProjects.GetMyProjectsAction.ViewModel.Success)
    func presenter(didFailGetMyProjects viewModel: MyProjects.GetMyProjectsAction.ViewModel.Failure)
    func presenter(didSucceedDeleteProject viewModel: MyProjects.DeleteProjectAction.ViewModel.Success)
    func presenter(didFailDeleteProject viewModel: MyProjects.DeleteProjectAction.ViewModel.Failure)
}

class MyProjectsViewController: UIViewController {
    var myProjectsView: MyProjectsView?
    var interactor: MyProjectsInteractorProtocol?
    var router: MyProjectsRouterProtocol?

    private var projects = [MyProjects.MProject]() {
        didSet {
            myProjectsView?.tableView.reloadData()
        }
    }

    override func loadView() {
        super.loadView()
        self.view = myProjectsView
        setupActions()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = MyProjects.GetMyProjectsAction.Request()
        interactor?.getMyProjects(request: request)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            router?.shouldClose()
        }
    }

    deinit {
        print("deinit \(self)")
    }
}

extension MyProjectsViewController {
    private func setupActions() {
        myProjectsView?.addProjectButtonAction = { [weak self] in
            self?.router?.addNewProject()
        }
    }

    private func setupTableView() {
        myProjectsView?.tableView.dataSource = self
        myProjectsView?.tableView.delegate = self
        myProjectsView?.tableView.register(UINib(nibName: MyProjectsTableViewCell.reuseIdentifier, bundle: nil),
                                           forCellReuseIdentifier: MyProjectsTableViewCell.reuseIdentifier)
    }
}

extension MyProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        projects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyProjectsTableViewCell.reuseIdentifier, for: indexPath) as? MyProjectsTableViewCell else { return UITableViewCell() }
        let project = projects[indexPath.row]
        cell.setupWith(project: project)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let projectId = projects[indexPath.row].id else { return nil }
        let deleteProjectAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.showDestructiveAlert(title: "Are you sure you want to delete project?", message: "This action cannot be undone") {
                let request = MyProjects.DeleteProjectAction.Request(projectId: projectId)
                self?.interactor?.deleteProject(request: request)
            }
            completion(true)
        }
        let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [deleteProjectAction])
        return swipeActionsConfiguration
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let project = projects[indexPath.row]
        guard let projectId = project.id else { return }
        router?.showEditProject(projectId: projectId)
    }
}

extension MyProjectsViewController: MyProjectsPresenterOutput {
    func presenter(didSucceedGetMyProjects viewModel: MyProjects.GetMyProjectsAction.ViewModel.Success) {
        projects = viewModel.projects
    }

    func presenter(didFailGetMyProjects viewModel: MyProjects.GetMyProjectsAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }

    func presenter(didSucceedDeleteProject viewModel: MyProjects.DeleteProjectAction.ViewModel.Success) {
        let request = MyProjects.GetMyProjectsAction.Request()
        interactor?.getMyProjects(request: request)
    }

    func presenter(didFailDeleteProject viewModel: MyProjects.DeleteProjectAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
