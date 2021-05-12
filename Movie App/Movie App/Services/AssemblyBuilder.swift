//
//  AssemblyBuilder.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(coordinator: MainCoordinator) -> UIViewController
    func createDetailModule(coordinator: MainCoordinator, viewModel: DetailViewModelType) -> UIViewController
    // TODO: Replace MAinCoordinator with coordinator
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createMainModule(coordinator: MainCoordinator) -> UIViewController {
        let view = MainViewController()
        view.coordinator = coordinator
        return view
    }

    func createDetailModule(coordinator: MainCoordinator, viewModel: DetailViewModelType) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        view.networkService = networkService
        view.photoService = PhotoService()
        view.viewModel = viewModel
        return view
    }
}
