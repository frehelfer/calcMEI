//
//  UIColor+.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let navBar = UIColor(named: "navBarColor")!
    
    let mainBackground = UIColor.secondarySystemBackground
    let greenBackground1 = UIColor(named: "greenBackground1")!
    let greenBackground2 = UIColor(named: "greenBackground2")!
    let greenBackground3 = UIColor(named: "greenBackground3")!
    
    let label1 = UIColor(named: "label1")!
}
