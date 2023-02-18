//
//  ExpensesViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class ExpensesViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var expensesView: ExpensesView = {
        let expensesView = ExpensesView()
        expensesView.delegate = self
        return expensesView
    }()
    
    var viewModel: ExpensesViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = expensesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar(color: .theme.navBar)
        setupVC()
    }
    
    // MARK: - Private Functions
    private func setupVC() {
        hideKeyboardWhenTappedAround()
    }
}

// MARK: - ExpensesViewDelegate
extension ExpensesViewController: ExpensesViewDelegate {
    
    func nextButtonPressed() {
        viewModel?.nextSelected()
    }
    
}

// MARK: - ExpensesViewModelViewDelegate
extension ExpensesViewController: ExpensesViewModelViewDelegate {
    
    
    
}
