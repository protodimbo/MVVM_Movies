//
//  TableViewCellViewModelType.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

protocol TableViewCellViewModelType: AnyObject {
    var voteAverage: Double { get }
    var filmImage: UIImage? { get }
    var filmName: String { get }
    var stringVoteAverage: String { get }
    var releaseDate: String { get }
    var heartImage: UIImage? { get }
}
