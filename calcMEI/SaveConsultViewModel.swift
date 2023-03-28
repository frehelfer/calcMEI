//
//  SaveConsultViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import Foundation

protocol SaveConsultViewModelCoordinatorDelegate: AnyObject {
    func saveConsultViewModelDidSelectSave(_ saveConsultViewModel: SaveConsultViewModel)
}

protocol SaveConsultViewModelViewDelegate: AnyObject {
    func saveConsultViewModel(_ saveConsultViewModel: SaveConsultViewModel, updateViewWithCount: Count)
}

class SaveConsultViewModel {
    
    weak var coordinatorDelegate: SaveConsultViewModelCoordinatorDelegate?
    weak var viewDelegate: SaveConsultViewModelViewDelegate?
    
    private let consultService: ConsultService
    
    var count: Count
    
    init(consultService: ConsultService, count: Count) {
        self.consultService = consultService
        self.count = count
    }
    
    var title: String {
        return "Salvar Consulta"
    }
    
    public func updateViewWithCount() {
        viewDelegate?.saveConsultViewModel(self, updateViewWithCount: count)
    }
    
    public func updateCount(countName: String) {
        count.name = countName
    }
    
    public func saveConsult() {
        consultService.createConsult(count: count)
    }
}

// MARK: - Navigation
extension SaveConsultViewModel {
    
    func saveSelected() {
        coordinatorDelegate?.saveConsultViewModelDidSelectSave(self)
    }
    
}
