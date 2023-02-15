//
//  ResultCoordinator.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class ResultCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    func start() {
        let viewController = ResultViewController()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
}
