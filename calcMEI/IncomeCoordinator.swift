//
//  IncomeCoordinator.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class IncomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    func start() {
        let viewController = IncomeViewController()
        
        viewController.presentNextScreen = {
            let coordinator = ExpensesCoordinator(navigationController: self.navigationController)
            coordinator.start()
        }
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
