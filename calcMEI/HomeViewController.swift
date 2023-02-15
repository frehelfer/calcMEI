//
//  HomeViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Clousures
    
    // MARK: - Properties
    
    lazy var homeView: HomeView = {
        let view = HomeView()

        return view
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStatusBar(color: .theme.navBar)
        
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        title = "calcMEI"

    }
}

// MARK: - Actions

extension HomeViewController {
    
}