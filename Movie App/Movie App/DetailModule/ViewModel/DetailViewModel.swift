//
//  DetailViewModel.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import Foundation

final class DetailViewModel: DetailViewModelType {
    var title: String {
        film.title
    }

    var info: String {
        film.overview
    }

    private var film: FilmResult

    init(film: FilmResult) {
        self.film = film
    }
}
