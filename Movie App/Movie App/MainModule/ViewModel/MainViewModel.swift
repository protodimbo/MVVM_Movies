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
    var coreDataService: CoreDataService?
    var film: Film?
    var films: [FilmResult]?

    func nuberOfRows() -> Int {
        film?.results.count ?? 0
    }

    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        guard let filmForCell = film?.results[indexPath.row] else { return nil }
        return TableViewCellViewModel(film: filmForCell)
    }

    func selectRow(at indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }

    func getFilm(category: MovieCategory, completion: @escaping () -> ()) {
        coreDataService?.fetch(for: category) { [weak self] filmResult in
            self?.films = filmResult
            completion()
        }
        networkService?.getFilms(category: category) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(film):
                    self?.film = film
                    self?.films = film.results
                    self?.coreDataService?.performSave { context in
                        for film in film.results {
                            let filmEntity = FilmResultDB(context: context)
                            filmEntity.backdropPath = film.backdropPath
                            filmEntity.id = Int64(film.id)
                            filmEntity.overview = film.overview
                            filmEntity.title = film.title
                            filmEntity.voteAverage = film.voteAverage
                        }
                    }
                    completion()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    init(networkService: NetworkServiceProtocol, coreDataService: CoreDataService) {
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
}
