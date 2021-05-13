//
//  DetailPhotoViewModel.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

final class DetailPhotoViewModel: DetailPhotoViewModelType {
    private var photoService: PhotoService?
    private var networkService: NetworkServiceProtocol?
    private var posters: [Posters]?
    var images: [UIImage?] = []
    var film: FilmResult?

    func getPosters(completion: @escaping () -> ()) {
        networkService?.getImages(for: String(film?.id ?? 0)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(posters):
                    self?.posters = posters
                    self?.getImages()
                    completion()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func getImages() {
        let group = DispatchGroup()
        guard let unwrappedPosters = posters else { return }
        for poster in unwrappedPosters {
            group.enter()
            photoService?.getPhoto(path: poster.filePath) { [weak self] image in
                self?.images.append(image)
                group.leave()
            }
        }
    }

    init(networkService: NetworkServiceProtocol, photoService: PhotoService, film: FilmResult?) {
        self.networkService = networkService
        self.photoService = photoService
        self.film = film
    }
}
