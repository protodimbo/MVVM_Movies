//
//  AssemblyBuilder.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(coordinator: MainCoordinator, coreDataService: DataBaseProtocol) -> UIViewController
    func createDetailModule(film: FilmResult?) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    // MARK: - Private Properties

    private let networkService = NetworkService()
    private let photoService = PhotoService()
    private let coreDataService = CoreDataService()

    // MARK: - Public Methods

    func createMainModule(coordinator: MainCoordinator, coreDataService: DataBaseProtocol) -> UIViewController {
        let view = MainViewController()
        view.coordinator = coordinator
        return view
    }

    func createDetailModule(film: FilmResult?) -> UIViewController {
        let view = DetailViewController()
        let viewModel = DetailPhotoViewModel(networkService: networkService, photoService: photoService, film: film)
        view.inject(viewModel: viewModel)
        return view
    }
}
