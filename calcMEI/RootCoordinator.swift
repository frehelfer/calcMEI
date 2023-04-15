//
//  RootCoordinator.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit
import CalcMEI_Core

class RootCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let calcMEI_core: CalcMEI_Core
    
    required init(navigationController: UINavigationController, calcMEI_core: CalcMEI_Core) {
        self.navigationController = navigationController
        self.calcMEI_core = calcMEI_core
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
        
        let homeCoordinator = HomeCoordinator(
            navigationController: self.navigationController,
            calcMEI_core: self.calcMEI_core
        )
        
        homeCoordinator.delegate = self
        return homeCoordinator
    }
    
}

// MARK: - HomeCoordinatorDelegate
extension RootCoordinator: HomeCoordinatorDelegate {
    
}

