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
    func consultsViewModelHasNoConsults(_ consultsViewModel: ConsultsViewModel)
}

class ConsultsViewModel {
    
    weak var coordinatorDelegate: ConsultsViewModelCoordinatorDelegate?
    weak var viewDelegate: ConsultsViewModelViewDelegate?
    
    private let consultService: ConsultServiceProtocol
    private let analyticsSerivce: AnalyticsServiceProtocol
    
    private(set) var consults: [Consult] = []
    
    init(consultService: ConsultServiceProtocol, analyticsService: AnalyticsServiceProtocol) {
        self.consultService = consultService
        self.analyticsSerivce = analyticsService
    }
    
    var title: String = S.Consults.title
    
    func loadConsults() {
        guard let consults = consultService.fetchConsults(), !consults.isEmpty else {
            viewDelegate?.consultsViewModelHasNoConsults(self)
            return
        }
        self.consults = consults
        viewDelegate?.consultsViewModel(self, didUpdateConsults: consults)
    }
    
    func remove(at index: IndexPath) {
        let consult = consults.remove(at: index.row)
        consultService.deleteConsult(consult: consult)
    }
    
}

// MARK: - Navigation
extension ConsultsViewModel {
    
    func newConsultSelected() {
        analyticsSerivce.logEvent(name: "ConsultsView_NewConsultSelected", params: nil)
        coordinatorDelegate?.consultsViewModelDidSelectNewConsult(self)
    }
    
    func detailSelected(consult: Consult) {
        analyticsSerivce.logEvent(name: "ConsultsView_DetailSelected", params: nil)
        coordinatorDelegate?.consultsViewModelDidSelectDetail(self, consult: consult)
    }
    
}
