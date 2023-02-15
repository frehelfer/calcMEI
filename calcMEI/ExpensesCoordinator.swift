//
//  ExpensesCoordinator.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class ExpensesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    func start() {
        let viewController = ExpensesViewController()
        
        viewController.presentNextScreen = {
            let coordinator = ResultCoordinator(navigationController: self.navigationController)
            coordinator.start()
        }
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
}
