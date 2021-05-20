// MainViewController.swift

import UIKit

/// Main screen of the app
final class MainViewController: UITableViewController {
    // MARK: - Public Properties

    weak var coordinator: MainCoordinator?
    weak var coreDataService: CoreDataService?

    // MARK: - Private Properties

    private var viewModel: MainViewModelType?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMainScreen()
        getFilm()
    }

    // MARK: - Private Methods

    private func configureMainScreen() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        title = "Netflix"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel = MainViewModel(
            networkService: NetworkService(),
            coreDataService: coreDataService ?? CoreDataService()
        )
    }

    private func getFilm() {
        viewModel?.getFilm(category: .nowPlaying) { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table View Methods

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
        coordinator?.toDetail(film: viewModel?.films?[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categoryView = CategoryView()
        categoryView.delegate = self
        return categoryView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}

// MARK: - Extensions

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MovieCategory.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath
        ) as? CategoryCollectionViewCell
        cell?.setup(text: MovieCategory.allCases[indexPath.row].rawValue)
        return cell ?? UICollectionViewCell()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.getFilm(category: MovieCategory.allCases[indexPath.row]) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MainViewController: CategoryViewDelegate {
    func setupCollectionViewDelegate() -> UICollectionViewDelegate {
        self
    }

    func setupCollectionViewDataSource() -> UICollectionViewDataSource {
        self
    }
}
