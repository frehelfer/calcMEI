//
//  Coordinator.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    func start()
    
    init(navigationController: UINavigationController)
}
