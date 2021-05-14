//
//  TableViewModelType.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import Foundation

protocol MainViewModelType {
    var films: [FilmResult]? { get set }
    func nuberOfRows() -> Int
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType?

    func selectRow(at indexPath: IndexPath)
    func getFilm(category: MovieCategory, completion: @escaping () -> ())

    init(networkService: NetworkServiceProtocol, coreDataService: CoreDataService)
}
