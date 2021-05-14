// Film.swift

import Foundation

/// Film model
struct Film: Codable {
    let page: Int
    let results: [FilmResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

/// Model of film results
struct FilmResult: Codable {
    let backdropPath: String
    let id: Int
    let originalTitle, overview: String
    let releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }

    internal init(filmResultDB: FilmResultDB) {
        backdropPath = filmResultDB.backdropPath
        id = Int(filmResultDB.id)
        originalTitle = filmResultDB.originalTitle
        overview = filmResultDB.overview
        releaseDate = filmResultDB.releaseDate
        title = filmResultDB.title
        voteAverage = filmResultDB.voteAverage
    }
}
