//
//  IncomeViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class IncomeViewController: UIViewController {
    
    // MARK: - Clousures
    
    // MARK: - Properties
    
    lazy var incomeView: IncomeView = {
        let view = IncomeView()
        
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = incomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Actions

extension IncomeViewController {
    
}
