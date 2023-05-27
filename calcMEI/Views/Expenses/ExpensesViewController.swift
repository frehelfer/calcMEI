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
            action: #selector(nextNavButtonPressed)
        )
    }
    
    @objc private func nextNavButtonPressed() {
        expensesView.nextNavButtonPressed()
    }
}

// MARK: - ExpensesViewDelegate
extension ExpensesViewController: ExpensesViewDelegate {
    
    func nextButtonPressed(expenses: Double) {
        viewModel?.updateCount(expenses: expenses)
        viewModel?.nextSelected()
    }
    
}
