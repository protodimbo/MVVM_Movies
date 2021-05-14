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

/// Model for posters
struct Posters: Codable {
    let aspectRatio: Double
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
    }
}
