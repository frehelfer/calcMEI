//
//  Coordinator.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    init(navigationController: UINavigationController)
    
    func start()
}

extension Coordinator {

    func startCoordinator(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
