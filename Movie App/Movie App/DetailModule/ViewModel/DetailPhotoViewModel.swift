//
//  DetailPhotoViewModel.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

final class DetailPhotoViewModel: DetailPhotoViewModelType {
    // MARK: - Public Properties

    var images: [UIImage?] = []
    var film: FilmResult?

    // MARK: - Private Properties

    private var photoService: PhotoService?
    private var networkService: NetworkServiceProtocol?
    private var posters: [Posters]?

    // MARK: - Initializers

    init(networkService: NetworkServiceProtocol, photoService: PhotoService, film: FilmResult?) {
        self.networkService = networkService
        self.photoService = photoService
        self.film = film
    }

    // MARK: - Public Methods

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
}
