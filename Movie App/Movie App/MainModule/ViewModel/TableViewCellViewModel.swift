//
//  TableViewCellViewModel.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

final class TableViewCellViewModel: TableViewCellViewModelType {
    private var film: FilmResult
    private var photoService = PhotoService()

    var voteAverage: Double {
        film.voteAverage
    }

    var filmImage: UIImage {
        var imageToReturn: UIImage?
        photoService.getPhoto(path: film.posterPath) { image in
            imageToReturn = image
        }
        return imageToReturn ?? UIImage()
    }

    var filmName: String {
        film.title
    }

    var stringVoteAverage: String {
        String(film.voteAverage)
    }

    var releaseDate: String {
        film.releaseDate
    }

    var heartImage: UIImage {
        switch film.voteAverage {
        case 0 ..< 0.5:
            return UIImage(named: "0") ?? UIImage()
        case 0.5 ..< 1:
            return UIImage(named: "0.5") ?? UIImage()
        case 1 ..< 1.5:
            return UIImage(named: "1") ?? UIImage()
        case 1.5 ..< 2:
            return UIImage(named: "1.5") ?? UIImage()
        case 2 ..< 2.5:
            return UIImage(named: "2") ?? UIImage()
        case 2.5 ..< 3:
            return UIImage(named: "2.5") ?? UIImage()
        case 3 ..< 3.5:
            return UIImage(named: "3") ?? UIImage()
        case 3.5 ..< 4:
            return UIImage(named: "3.5") ?? UIImage()
        case 4 ..< 4.5:
            return UIImage(named: "4") ?? UIImage()
        case 4.5 ..< 5:
            return UIImage(named: "4.5") ?? UIImage()
        case 5 ..< 5.5:
            return UIImage(named: "5") ?? UIImage()
        case 5.5 ..< 6:
            return UIImage(named: "5.5") ?? UIImage()
        case 6 ..< 6.5:
            return UIImage(named: "6") ?? UIImage()
        case 6.5 ..< 7:
            return UIImage(named: "6.5") ?? UIImage()
        case 7 ..< 7.5:
            return UIImage(named: "7") ?? UIImage()
        case 7.5 ..< 8:
            return UIImage(named: "7.5") ?? UIImage()
        case 8 ..< 8.5:
            return UIImage(named: "8") ?? UIImage()
        case 8.5 ..< 9:
            return UIImage(named: "8.5") ?? UIImage()
        case 9 ..< 9.5:
            return UIImage(named: "9") ?? UIImage()
        case 9.5 ..< 10:
            return UIImage(named: "9.5") ?? UIImage()
        case 10:
            return UIImage(named: "10") ?? UIImage()
        default:
            return UIImage(named: "0") ?? UIImage()
        }
    }

    init(film: FilmResult) {
        self.film = film
    }
}
