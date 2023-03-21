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
    
    var appVersion: String {
        guard
            let versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        else {
            return ""
        }
        
        return "v\(versionNumber) \(buildNumber)"
    }
}

// MARK: - Navigation
extension SettingsViewModel {
    
    
    
}
