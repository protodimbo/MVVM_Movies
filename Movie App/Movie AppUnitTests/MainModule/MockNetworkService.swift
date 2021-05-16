//
//  MockNetworkService.swift
//  Movie AppUnitTests
//
//  Created by  protodimbo on 15.05.2021.
//
import Foundation
@testable import Movie_App

final class MockNetworkService: NetworkServiceProtocol {
    private var film: Film?
    private var posters: [Posters]?

    init(film: Film) {
        self.film = film
    }

    init(posters: [Posters]) {
        self.posters = posters
    }

    init() {}

    func getFilms(category: MovieCategory, completion: @escaping (Result<Film, Error>) -> Void) {
        if let film = film {
            completion(.success(film))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }

    func getImages(for id: String, completion: @escaping (Result<[Posters]?, Error>) -> Void) {
        if let posters = posters {
            completion(.success(posters))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}
