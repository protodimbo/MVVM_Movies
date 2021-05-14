//
//  DetailPhotoViewModelType.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

protocol DetailPhotoViewModelType {
    var images: [UIImage?] { get set }
    var film: FilmResult? { get set }
    func getPosters(completion: @escaping () -> ())

    init(networkService: NetworkServiceProtocol, photoService: PhotoService, film: FilmResult?)
}
