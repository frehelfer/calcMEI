//
//  HomeViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.delegate = self
        return homeView
    }()
    
    var viewModel: HomeViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar(color: .theme.navBar)
        setupVC()
    }
    
    // MARK: - Private Functions
    private func setupVC() {
        hideKeyboardWhenTappedAround()
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(settingsButtonPressed)
        )
    }
    
    // MARK: - Navigation
    @objc private func settingsButtonPressed() {
        viewModel?.settingsSelected()
    }
    
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    
    func nextButtonPressed() {
        viewModel?.startSelected()
    }
    
}

// MARK: - HomeViewModelViewDelegate
extension HomeViewController: HomeViewModelViewDelegate {
    
    
    
}
