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
        hideKeyboardWhenTappedAround()
        setupKeyboardHiding()
        setupNavigationItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            viewModel?.backButtonSelected()
        }
    }
    
    // MARK: - Private Functions
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: S.Expenses.NextButton.title,
            style: .plain,
            target: self,
            action: #selector(nextNavButtonSelected)
        )
    }
    
    @objc private func nextNavButtonSelected() {
        expensesView.nextNavButtonPressed()
    }
}

// MARK: - ExpensesViewDelegate
extension ExpensesViewController: ExpensesViewDelegate {
    
    func nextBottomButtonPressed(expenses: Double) {
        viewModel?.updateCount(expenses: expenses)
        viewModel?.nextBottomButtonSelected()
    }
    
    func nextNavButtonPressed(expenses: Double) {
        viewModel?.updateCount(expenses: expenses)
        viewModel?.nextNavButtonSelected()
    }
    
}
