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
    private let calcMEI_SDK: CalcMEI_SDK
    
    required init(navigationController: UINavigationController, calcMEI_SDK: CalcMEI_SDK) {
        self.navigationController = navigationController
        self.calcMEI_SDK = calcMEI_SDK
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
            calcMEI_SDK: self.calcMEI_SDK
        )
        
        homeCoordinator.delegate = self
        return homeCoordinator
    }
    
}

// MARK: - HomeCoordinatorDelegate
extension RootCoordinator: HomeCoordinatorDelegate {
    
}

