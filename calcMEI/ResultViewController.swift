//
//  ResultViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var resultView: ResultView = {
        let resultView = ResultView()
        resultView.delegate = self
        return resultView
    }()
    
    var viewModel: ResultViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = resultView
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

// MARK: - ResultViewDelegate
extension ResultViewController: ResultViewDelegate {
    
    func nextButtonPressed() {
        viewModel?.resetSelected()
    }
    
}

// MARK: - ResultViewModelViewDelegate
extension ResultViewController: ResultViewModelViewDelegate {
    
    
    
}
