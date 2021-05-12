// MainViewController.swift

import UIKit

/// Main screen of the app
final class MainViewController: UITableViewController {
    private var viewModel: MainViewModelType?

    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMainScreen()
        getFilm()
    }

    private func configureMainScreen() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        //  fetchData()
        title = "Netflix"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel = MainViewModel(networkService: NetworkService())
    }

    private func getFilm() {
        viewModel?.getFilm { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.nuberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FilmTableViewCell.identifier,
            for: indexPath
        ) as? FilmTableViewCell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(indexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        190
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(at: indexPath)
        guard let viewModelForSelected = viewModel.viewModelForSelectedRow() else { return }

        coordinator?.toDetail(viewModel: viewModelForSelected)
    }
}
