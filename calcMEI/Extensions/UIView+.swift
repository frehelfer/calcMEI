//
//  UIView+.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 21/04/23.
//

import UIKit

enum Corner {
    case top
    case bottom
}

extension UIView {
    
    func modifyCornerRadius(corner: Corner, radius: CGFloat) {
        switch corner {
        case .top:
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        self.clipsToBounds = true
    }
    
}
