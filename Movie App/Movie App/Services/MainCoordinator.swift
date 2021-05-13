//
//  MainCoordinator.swift
//  Movie App
//
//  Created by  protodimbo on 11.05.2021.
//

import UIKit

final class MainCoordinator: Coordinator {
    private var assemblyBuilder: AssemblyBuilderProtocol
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func start() {
        let mainViewController = assemblyBuilder.createMainModule(coordinator: self)
        navigationController.pushViewController(mainViewController, animated: false)
    }

    func toDetail(film: FilmResult?) {
        let detailViewController = assemblyBuilder
            .createDetailModule(film: film)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
