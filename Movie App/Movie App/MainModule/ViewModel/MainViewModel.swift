//
//  MainViewModel.swift
//  Movie App
//
//  Created by  protodimbo on 11.05.2021.
//

import Foundation

final class MainViewModel: MainViewModelType {
    private var selectedIndexPath: IndexPath?
    var networkService: NetworkServiceProtocol?
    var film: Film?

    func nuberOfRows() -> Int {
        film?.results.count ?? 0
    }

    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        guard let filmForCell = film?.results[indexPath.row] else { return nil }
        return TableViewCellViewModel(film: filmForCell)
    }

    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath,
              let filmForRow = film?.results[selectedIndexPath.row] else { return nil }
        return DetailViewModel(film: filmForRow)
    }

    func selectRow(at indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }

    func getFilm(completion: @escaping () -> ()) {
        networkService = NetworkService()
        networkService?.getFilms(category: .nowPlaying) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(film):
                    self?.film = film
                    completion()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
