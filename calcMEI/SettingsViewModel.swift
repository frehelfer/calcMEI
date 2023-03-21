//
//  SettingsViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 20/03/23.
//

import Foundation

protocol SettingsViewModelCoordinatorDelegate: AnyObject {
    
}

protocol SettingsViewModelViewDelegate: AnyObject {
    
}

class SettingsViewModel {
    
    weak var coordinatorDelegate: SettingsViewModelCoordinatorDelegate?
    weak var viewDelegate: SettingsViewModelViewDelegate?
    
    init() {
        
    }
    
    var title: String {
        return "Settings"
    }
}

// MARK: - Navigation
extension SettingsViewModel {
    
    
    
}
