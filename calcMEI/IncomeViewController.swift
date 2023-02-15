//
//  IncomeViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class IncomeViewController: UIViewController {
    
    // MARK: - Clousures
    
    var presentNextScreen: (() -> Void)?
    
    // MARK: - Properties
    
    private var incomeView = IncomeView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = incomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incomeView.delegate = self
        setStatusBar(color: .theme.navBar)
        setupVC()
    }
    
    // MARK: - Private Functions
    
    private func setupVC() {
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        title = "Receita Anual"
    }
}

// MARK: - IncomeViewDelegate
extension IncomeViewController: IncomeViewDelegate {
    func nextButtonPressed() {
        self.presentNextScreen?()
    }
}
