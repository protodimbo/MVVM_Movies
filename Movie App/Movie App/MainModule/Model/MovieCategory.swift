//
//  MovieCategory.swift
//  Movie App
//
//  Created by  protodimbo on 11.05.2021.
//

import Foundation

/// Movie categories for request
enum MovieCategory: String, CaseIterable {
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"

    var correctName: String {
        switch self {
        case .nowPlaying:
            return "now_playing"
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        }
    }
}
