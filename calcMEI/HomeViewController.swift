//
//  HomeViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Clousures
    
    var presentNextScreen: (() -> Void)?
    
    // MARK: - Properties
    
    private var homeView = HomeView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
        setStatusBar(color: .theme.navBar)
        setupVC()
    }
    
    // MARK: - Private Functions
    
    private func setupVC() {
        hideKeyboardWhenTappedAround()
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        title = "calcMEI"
    }
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    func nextButtonPressed() {
        self.presentNextScreen?()
    }
}
