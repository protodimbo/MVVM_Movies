//
//  DetailViewController.swift
//  Movie App
//
//  Created by  protodimbo on 05.03.2021.
//

import UIKit

/// Detail vc
final class DetailViewController: UIViewController {
    // MARK: - Private Properties

    private var viewModel: DetailPhotoViewModelType?

    private var detailTableView = DetailView(frame: .zero)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        view = detailTableView
        title = viewModel?.film?.originalTitle
        getPosters()
    }

    // MARK: - Public Methods

    func inject(viewModel: DetailPhotoViewModelType) {
        self.viewModel = viewModel
    }

    // MARK: - Private Methods

    private func getPosters() {
        viewModel?.getPosters { [weak self] in
            self?.detailTableView.detailTableView.reloadData()
        }
    }
}

// MARK: - Extensions

extension DetailViewController: DetailViewDelegate {
    func setupTableViewDelegate() -> UITableViewDelegate {
        self
    }

    func setupTableViewDataSource() -> UITableViewDataSource {
        self
    }
}

extension DetailViewController: UITableViewDelegate {}
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DetailPhotosScrollViewTableViewCell.identifier,
                for: indexPath
            ) as? DetailPhotosScrollViewTableViewCell,
                let photoViewModel = viewModel else { return UITableViewCell() }
            cell.configure(images: photoViewModel.images)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DetailTitleTableViewCell.identifier,
                for: indexPath
            ) as? DetailTitleTableViewCell, let viewModel = viewModel else { return UITableViewCell() }
            cell.configure(text: viewModel.film?.title)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DetailInfoTableViewCell.identifier,
                for: indexPath
            ) as? DetailInfoTableViewCell, let viewModel = viewModel else { return UITableViewCell() }
            cell.configure(text: viewModel.film?.overview)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
