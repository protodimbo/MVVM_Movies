//
//  MovieCategory.swift
//  Movie App
//
//  Created by  protodimbo on 11.05.2021.
//

import Foundation

/// Movie categories for request
enum MovieCategory: String {
    case latest
    case nowPlaying
    case popular
    case topRated
    case upcoming

    var correctName: String {
        switch self {
        case .latest:
            return "latest"
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
