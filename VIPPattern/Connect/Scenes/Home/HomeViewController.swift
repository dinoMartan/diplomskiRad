 //
//  HomeViewController.swift
//  Connect
//
//  Created by Dino Martan on 25.05.2022..
//

import UIKit

protocol HomePresenterOutput: AnyObject {
    func presenter(didSucceedGetAllProjects viewModel: Home.GetAllProjectsAction.ViewModel.Success)
    func presenter(didFailGetAllProjects viewModel: Home.GetAllProjectsAction.ViewModel.Failure)
    func presenter(didSucceedGetProjectsWithNeed viewModel: Home.GetProjectsWithNeed.ViewModel.Success)
    func presenter(didFailGetProjectsWithNeed viewModel: Home.GetProjectsWithNeed.ViewModel.Failure)
}

class HomeViewController: UIViewController {
    var homeView: HomeView?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?

    private var projects = [Home.HProject]() {
        didSet {
            homeView?.tableView.reloadData()
        }
    }

    override func loadView() {
        super.loadView()
        self.view = homeView
        setupTableView()
        setupSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        let request = Home.GetAllProjectsAction.Request()
        interactor?.getAllProjects(request: request)
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

extension HomeViewController {
    private func setupTableView() {
        homeView?.tableView.delegate = self
        homeView?.tableView.dataSource = self
        homeView?.tableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil),
                                     forCellReuseIdentifier: HomeTableViewCell.identifier)
    }

    private func setupSearchBar() {
        homeView?.searchBar.delegate = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        projects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let project = projects[indexPath.row]
        cell.setupWith(project: project)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let projectId = projects[indexPath.row].projectId else { return }
        router?.showProjectDetails(projectId: projectId)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            getAllProjects()
            return
        }
        getProjectsForText(searchText)
    }

    private func getProjectsForText(_ text: String) {
        let request = Home.GetProjectsWithNeed.Request(need: text)
        interactor?.getProjectsWithNeed(request: request)
    }

    private func getAllProjects() {
        let request = Home.GetAllProjectsAction.Request()
        interactor?.getAllProjects(request: request)
    }
}

extension HomeViewController: HomePresenterOutput {
    func presenter(didSucceedGetAllProjects viewModel: Home.GetAllProjectsAction.ViewModel.Success) {
        projects = viewModel.projects
    }

    func presenter(didFailGetAllProjects viewModel: Home.GetAllProjectsAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }

    func presenter(didSucceedGetProjectsWithNeed viewModel: Home.GetProjectsWithNeed.ViewModel.Success) {
        projects = viewModel.projects
    }

    func presenter(didFailGetProjectsWithNeed viewModel: Home.GetProjectsWithNeed.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
