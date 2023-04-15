//
//  ConsultsViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit
import CalcMEI_Core

protocol ConsultsViewModelCoordinatorDelegate: AnyObject{
    func consultsViewModelDidSelectNewConsult(_ consultsViewModel: ConsultsViewModel)
    func consultsViewModelDidSelectDetail(_ consultsViewModel: ConsultsViewModel, consult: Consult)
}

protocol ConsultsViewModelViewDelegate: AnyObject {
    func consultsViewModel(_ consultsViewModel: ConsultsViewModel, didUpdateConsults: [Consult])
}

class ConsultsViewModel {
    
    weak var coordinatorDelegate: ConsultsViewModelCoordinatorDelegate?
    weak var viewDelegate: ConsultsViewModelViewDelegate?
    
    private let consultService: ConsultServiceProtocol
    
    private(set) var consults: [Consult] = []
    
    init(consultService: ConsultServiceProtocol) {
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
            viewDelegate?.consultsViewModel(self, didUpdateConsults: consults)
        }
    }
    
    func remove(at index: IndexPath) {
        let consult = consults.remove(at: index.row)
        consultService.deleteConsult(consult: consult)
    }
    
}

// MARK: - Navigation
extension ConsultsViewModel {
    
    func newConsultSelected() {
        coordinatorDelegate?.consultsViewModelDidSelectNewConsult(self)
    }
    
    func detailSelected(consult: Consult) {
        coordinatorDelegate?.consultsViewModelDidSelectDetail(self, consult: consult)
    }
    
}
