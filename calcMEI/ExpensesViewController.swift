//
//  ExpensesViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class ExpensesViewController: UIViewController {
    
    // MARK: - Clousures
    
    var presentNextScreen: (() -> Void)?
    
    // MARK: - Properties
    
    private var expensesView = ExpensesView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = expensesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesView.delegate = self
        setStatusBar(color: .theme.navBar)
        setupVC()
    }
    
    // MARK: - Private Functions
    
    private func setupVC() {
        hideKeyboardWhenTappedAround()
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        title = "Despesas Anuais"
    }
}

// MARK: - ExpensesViewDelegate
extension ExpensesViewController: ExpensesViewDelegate {
    func nextButtonPressed() {
        self.presentNextScreen?()
    }
}
