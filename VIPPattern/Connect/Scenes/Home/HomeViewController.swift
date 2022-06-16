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
}

class HomeViewController: UIViewController {
    var viewHome: HomeView?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?

    override func loadView() {
        super.loadView()
        self.view = viewHome
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
        viewHome?.tableView.delegate = self
        viewHome?.tableView.dataSource = self
        viewHome?.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

extension HomeViewController: HomePresenterOutput {
    func presenter(didSucceedGetAllProjects viewModel: Home.GetAllProjectsAction.ViewModel.Success) {
        // TODO: populate table
    }

    func presenter(didFailGetAllProjects viewModel: Home.GetAllProjectsAction.ViewModel.Failure) {
        showMyErrorAlert(viewModel.myError)
    }
}
