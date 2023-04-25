//
//  ResultViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit
import CalcMEI_Core

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
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.updateViewWithCount()
    }
    
    // MARK: - Private Functions
}

// MARK: - ResultViewDelegate
extension ResultViewController: ResultViewDelegate {
    
    func nextButtonPressed() {
        viewModel?.resetSelected()
    }
    
    func saveButtonPressed() {
        viewModel?.saveConsultSelected()
    }
    
}

// MARK: - ResultViewModelViewDelegate
extension ResultViewController: ResultViewModelViewDelegate {
    
    func resultViewModel(_ resultViewMode: ResultViewModel, updateViewWithCount: Count) {
        resultView.updateView(with: updateViewWithCount)
    }
    
}
