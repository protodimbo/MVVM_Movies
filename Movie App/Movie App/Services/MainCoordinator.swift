//
//  MainCoordinator.swift
//  Movie App
//
//  Created by  protodimbo on 11.05.2021.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Public Properties

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: - Private Properties

    private var assemblyBuilder: AssemblyBuilderProtocol

    // MARK: - Initializers

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Public Methods

    func start(coreDataService: DataBaseProtocol) {
        let mainViewController = assemblyBuilder.createMainModule(coordinator: self, coreDataService: coreDataService)
        navigationController.pushViewController(mainViewController, animated: false)
    }

    func toDetail(film: FilmResult?) {
        let detailViewController = assemblyBuilder
            .createDetailModule(film: film)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
