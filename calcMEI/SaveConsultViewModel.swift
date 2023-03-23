//
//  SaveConsultViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import Foundation

protocol SaveConsultViewModelCoordinatorDelegate: AnyObject {
    
}

protocol SaveConsultViewModelViewDelegate: AnyObject {
    
}

class SaveConsultViewModel {
    
    weak var coordinatorDelegate: SaveConsultViewModelCoordinatorDelegate?
    weak var viewDelegate: SaveConsultViewDelegate?
    
    init() {
        
    }
    
}

// MARK: - Navigation
extension SaveConsultViewModel {
    
    
    
}
