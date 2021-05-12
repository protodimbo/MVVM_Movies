//
//  MainCoordinator.swift
//  Movie App
//
//  Created by  protodimbo on 11.05.2021.
//

import UIKit

final class MainCoordinator: Coordinator {
    var assemblyBuilder: AssemblyBuilderProtocol?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func start() {
        guard let mainViewController = assemblyBuilder?.createMainModule(coordinator: self) else { return }
        navigationController.pushViewController(mainViewController, animated: false)
    }

    func toDetail(viewModel: DetailViewModelType) {
        guard let detailViewController = assemblyBuilder?
            .createDetailModule(coordinator: self, viewModel: viewModel) as? DetailViewController else { return }
//        detailViewController.configure(
//            posterName: filmResult.posterPath,
//            title: filmResult.title,
//            info: filmResult.overview
//        )
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
