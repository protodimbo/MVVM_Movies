//
//  Poster.swift
//  Movie App
//
//  Created by  protodimbo on 11.05.2021.
//

import Foundation

/// Model for poster request
struct Poster: Codable {
    let id: Int
    let backdrops: [Posters]
}

/// MOdel for posters
struct Posters: Codable {
    let filmId: Int
    let aspectRatio: Double
    let filePath: String
}
