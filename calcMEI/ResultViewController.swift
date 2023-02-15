//
//  ResultViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - Clousures
    
    // MARK: - Properties
    
    private var resultView = ResultView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.delegate = self
        setStatusBar(color: .theme.navBar)
        setupVC()
    }
    
    // MARK: - Private Functions
    
    private func setupVC() {
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        title = "Resultado"
    }
}

// MARK: - ResultViewDelegate
extension ResultViewController: ResultViewDelegate {
    
}
