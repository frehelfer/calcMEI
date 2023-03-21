//
//  SettingsViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 20/03/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Clousures
    
    // MARK: - Properties
    
    lazy var settingsView: SettingsView = {
        let view = SettingsView()
        
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Actions

extension SettingsViewController {
    
}

