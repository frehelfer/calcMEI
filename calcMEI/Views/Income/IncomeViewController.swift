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
        setupKeyboardHiding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setupNavigationAppearance(
            backgroundColor: A.Colors.navBar.color
        )
    }
    
    // MARK: - Private Functions
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - IncomeViewDelegate
extension IncomeViewController: IncomeViewDelegate {
    
    func nextButtonPressed(incomeData: IncomeViewModel.IncomeData) {
        viewModel?.nextSelected(incomeData: incomeData)
    }
}
