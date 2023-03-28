//
//  ConsultsViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit

protocol ConsultsViewModelCoordinatorDelegate: AnyObject{
    func consultsViewModelDidSelectNewConsult(_ consultsViewModel: ConsultsViewModel)
}

protocol ConsultsViewModelViewDelegate: AnyObject {
    func consultsViewModel(_ consultsViewModel: ConsultsViewModel, didUpdateConsults: [Consult])
}

class ConsultsViewModel {
    
    weak var coordinatorDelegate: ConsultsViewModelCoordinatorDelegate?
    weak var viewDelegate: ConsultsViewModelViewDelegate?
    
    private let consultService: ConsultService
    
    private(set) var consults: [Consult] = [] {
        didSet {
            viewDelegate?.consultsViewModel(self, didUpdateConsults: consults)
        }
    }
    
    init(consultService: ConsultService) {
        self.consultService = consultService
    }
    
    var title: String {
        return "Consultas Salvas"
    }
    
    func loadConsults() {
        if let consults = consultService.fetchConsults() {
            // Fazer um MAP aqui?
            // Como seria o cálculo? Nem precisaria salvar as computed properties
            self.consults = consults
        }
    }
    
}

// MARK: - Navigation
extension ConsultsViewModel {
    
    func newConsultSelected() {
        coordinatorDelegate?.consultsViewModelDidSelectNewConsult(self)
    }
    
}
