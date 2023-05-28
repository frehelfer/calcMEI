//
//  IncomeViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class IncomeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var incomeView: IncomeView = {
        let homeView = IncomeView()
        homeView.delegate = self
        return homeView
    }()
    
    var viewModel: IncomeViewModel? {
        didSet {
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = incomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setupNavigationAppearance(
            backgroundColor: A.Colors.navBar.color
        )
        setupKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }
    
    // MARK: - Private Functions
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: S.Income.NextButton.title,
            style: .plain,
            target: self,
            action: #selector(nextNavButtonPressed)
        )
    }
    
    @objc private func nextNavButtonPressed() {
        incomeView.nextNavButtonPressed()
    }
    
}

// MARK: - KeyboardObserving
extension IncomeViewController {
    
    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowPrivate), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidePrivate), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShowPrivate(notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        guard let keyboardSize = (keyboardFrame as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        incomeView.updateScrollView(contentInsets: contentInsets)
    }

    @objc func keyboardWillHidePrivate(notification: Notification) {
        incomeView.updateScrollView(contentInsets: .zero)
    }
    
}

// MARK: - IncomeViewDelegate
extension IncomeViewController: IncomeViewDelegate {
    
    func nextButtonPressed(incomeData: IncomeViewModel.IncomeData) {
        viewModel?.nextSelected(incomeData: incomeData)
    }
}
