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
    
    private let consultService: ConsultService
    
    var count: Count
    
    init(consultService: ConsultService, count: Count) {
        self.consultService = consultService
        self.count = count
    }
    
    var title: String {
        return "Salvar Consulta"
    }
    
}

// MARK: - Navigation
extension SaveConsultViewModel {
    
    
    
}
