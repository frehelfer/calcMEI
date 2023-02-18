//
//  BaseNavigationController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .label
        navigationBar.prefersLargeTitles = true
        //        navigationBar.titleTextAttributes = [
        //            .font: FontFamily.Montserrat.bold.font(size: 15),
        //            .foregroundColor: Asset.Colors.grayDark.color
        //        ]
        //        navigationBar.largeTitleTextAttributes = [
        //            .font: FontFamily.Montserrat.bold.font(size: 35),
        //            .foregroundColor: Asset.Colors.grayDark.color
        //        ]
        
    }
}
