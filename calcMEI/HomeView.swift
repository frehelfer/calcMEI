//
//  HomeView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - Clousures
    
    // MARK: - Properties
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    private func addSubViews() {
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    // MARK: - Actions
    
}
