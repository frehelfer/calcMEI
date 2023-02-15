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
    
    lazy var resultView: ResultView = {
        let view = ResultView()
        
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Actions

extension ResultViewController {
    
}
