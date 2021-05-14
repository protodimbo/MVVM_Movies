//
//  Coordinator.swift
//  Movie App
//
//  Created by  protodimbo on 11.05.2021.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start(coreDataService: CoreDataService)
}
