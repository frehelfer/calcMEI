//
//  ExpensesViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class ExpensesViewController: UIViewController {
    
    // MARK: - Clousures
    
    // MARK: - Properties
    
    lazy var expensesView: ExpensesView = {
        let view = ExpensesView()
        
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = expensesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Actions

extension ExpensesViewController {
    
}
