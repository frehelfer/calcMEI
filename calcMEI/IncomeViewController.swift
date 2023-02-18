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
            viewModel?.viewDelegate = self
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
        setStatusBar(color: .theme.navBar)
        setupVC()
    }
    
    // MARK: - Private Functions
    private func setupVC() {
        
        hideKeyboardWhenTappedAround()
        setupKeyboardHiding()
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - IncomeViewDelegate
extension IncomeViewController: IncomeViewDelegate {
    
    func nextButtonPressed() {
        viewModel?.nextSelected()
    }
}

// MARK: - IncomeViewModelViewDelegate
extension IncomeViewController: IncomeViewModelViewDelegate {
    
    
    
}
