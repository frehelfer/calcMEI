//
//  UINavigationBar+.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 21/05/23.
//

import UIKit

extension UINavigationBar {
    
    func setupNavigationAppearance(
        prefersLargeTitles: Bool = true,
        backgroundColor: UIColor = .white,
        isTranslucent: Bool = true
    ) {

        self.prefersLargeTitles = prefersLargeTitles
        self.tintColor = A.Colors.labelPrimary.color
        self.isTranslucent = isTranslucent

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = backgroundColor
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = .init()
        //            navBarAppearance.titleTextAttributes = [
        //                .font: FontFamily.Montserrat.bold.font(size: 15),
        //                .foregroundColor: Asset.Colors.grayDark.color
        //            ]
        //            navBarAppearance.largeTitleTextAttributes = [
        //                .font: FontFamily.Montserrat.bold.font(size: 35),
        //                .foregroundColor: Asset.Colors.grayDark.color
        //            ]
        self.standardAppearance = navBarAppearance
        self.scrollEdgeAppearance = navBarAppearance
        self.compactAppearance = navBarAppearance
    }
}
