//
//  RootCoordinator.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit

class RootCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
}

// MARK: - Navigation
private extension RootCoordinator {
    
    func showHome() {
        startCoordinator(coordinator: homeCoordinator())
    }
    
}

// MARK: - Child Coordinators
private extension RootCoordinator {
    
    func homeCoordinator() -> Coordinator {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
        homeCoordinator.delegate = self
        return homeCoordinator
    }
    
}

// MARK: - HomeCoordinatorDelegate
extension RootCoordinator: HomeCoordinatorDelegate {
    
}

