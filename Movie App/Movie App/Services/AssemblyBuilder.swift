//
//  AssemblyBuilder.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(coordinator: MainCoordinator, coreDataService: CoreDataService) -> UIViewController
    func createDetailModule(film: FilmResult?) -> UIViewController
    // TODO: Replace MAinCoordinator with coordinator
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    private let networkService = NetworkService()
    private let photoService = PhotoService()
    private let coreDataService = CoreDataService()

    func createMainModule(coordinator: MainCoordinator, coreDataService: CoreDataService) -> UIViewController {
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
