//
//  DetailViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import Foundation

protocol DetailViewModelCoordinatorDelegate: AnyObject {
    func detailViewModelDidSelectDismiss(_ detailViewModel: DetailViewModel)
}

protocol DetailViewModelViewDelegate: AnyObject {
    
}

class DetailViewModel {

    weak var coordinatorDelegate: DetailViewModelCoordinatorDelegate?
    weak var viewDelegate: DetailViewModelViewDelegate?
    
    private let consultService: ConsultService
    
    let consult: Consult
    
    init(consultService: ConsultService, consult: Consult) {
        self.consultService = consultService
        self.consult = consult
    }
    
    var title: String {
        consult.name ?? ""
    }
    
    func deleteSelected() {
        consultService.deleteConsult(consult: consult)
        coordinatorDelegate?.detailViewModelDidSelectDismiss(self)
    }
    
}
