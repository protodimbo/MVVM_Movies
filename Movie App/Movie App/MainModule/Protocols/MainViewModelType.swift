//
//  TableViewModelType.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import Foundation

protocol MainViewModelType {
    func nuberOfRows() -> Int
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType?

    func viewModelForSelectedRow() -> DetailViewModelType?
    func selectRow(at indexPath: IndexPath)
    func getFilm(completion: @escaping () -> ())

    init(networkService: NetworkServiceProtocol)
}
