//
//  SettingsViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 20/03/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var settingsView: SettingsView = {
        let settingsView = SettingsView()
        settingsView.delegate = self
        settingsView.updateView(with: viewModel?.appVersion)
        return settingsView
    }()
    
    var viewModel: SettingsViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - SettingsViewController
extension SettingsViewController: SettingsViewDelegate {
    
    
    
}

// MARK: - SettingsViewModelViewDelegate
extension SettingsViewController: SettingsViewModelViewDelegate {
    
    
    
}

