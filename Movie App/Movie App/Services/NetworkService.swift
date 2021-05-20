//
//  NetworkService.swift
//  Movie App
//
//  Created by  protodimbo on 10.05.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getFilms(category: MovieCategory, completion: @escaping (Result<Film, Error>) -> Void)
    func getImages(for id: String, completion: @escaping (Result<[Posters]?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    // MARK: - Public Methods

    func getFilms(category: MovieCategory, completion: @escaping (Result<Film, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/movie/\(category.correctName)"
        let queryItemAPIKey = URLQueryItem(name: "api_key", value: "aca367d31340b3ecdf8975e6a8071834")
        let queryItemLanguage = URLQueryItem(name: "language", value: "ru")
        let queryItemPage = URLQueryItem(name: "page", value: "1")
        urlComponents.queryItems = [queryItemAPIKey, queryItemLanguage, queryItemPage]

        guard let url = urlComponents.url else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let filmResponse = try JSONDecoder().decode(Film.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(filmResponse))
                }
            } catch {
                // TODO: error handling
                print(error.localizedDescription)
            }
        }
        DispatchQueue.global().async {
            task.resume()
        }
    }

    func getImages(for id: String, completion: @escaping (Result<[Posters]?, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/movie/\(id)/images"
        let queryItemAPIKey = URLQueryItem(name: "api_key", value: "aca367d31340b3ecdf8975e6a8071834")
        urlComponents.queryItems = [queryItemAPIKey]

        guard let url = urlComponents.url else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let poster = try JSONDecoder().decode(Poster.self, from: data)
                completion(.success(poster.backdrops))
            } catch {
                // TODO: error handling
                print(error.localizedDescription)
            }
        }
        DispatchQueue.global().async {
            task.resume()
        }
    }
}
