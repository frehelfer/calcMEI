//
//  ConsultsViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit
import CalcMEI_Core

protocol ConsultsViewModelProtocol {
    var coordinatorDelegate: ConsultsViewModelCoordinatorDelegate? { get set }
    var viewDelegate: ConsultsViewModelViewDelegate? { get set }
    
    var title: String { get }
    
    func loadConsults()
    func getNumberOfRowsInSection() -> Int
    func getDataToCell(indexPath: IndexPath) -> ConsultsViewModel.CellData?
    func userEditingRow(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle)
    func remove(at index: IndexPath)
    
    func newConsultSelected()
    func detailSelected(indexPath: IndexPath)
}

protocol ConsultsViewModelCoordinatorDelegate: AnyObject{
    func consultsViewModelDidSelectNewConsult(_ consultsViewModel: ConsultsViewModelProtocol)
    func consultsViewModelDidSelectDetail(_ consultsViewModel: ConsultsViewModelProtocol, consult: Consult)
}

protocol ConsultsViewModelViewDelegate: AnyObject {
    func consultsViewModel(_ consultsViewModel: ConsultsViewModelProtocol, didUpdateConsults: [Consult])
    func consultsViewModelShowEmptyView(animate: Bool)
    func consultsViewModelShowDeleteAlert(title: String, message: String, confirmDeletePressed: @escaping () -> Void)
    func consultsViewModelDeleteTableViewRow(indexPath: IndexPath)
}

class ConsultsViewModel: ConsultsViewModelProtocol {
    
    weak var coordinatorDelegate: ConsultsViewModelCoordinatorDelegate?
    weak var viewDelegate: ConsultsViewModelViewDelegate?
    
    private let consultService: ConsultServiceProtocol
    private let analyticsSerivce: AnalyticsServiceProtocol
    
    private var consults: [Consult] = []
    
    init(consultService: ConsultServiceProtocol, analyticsService: AnalyticsServiceProtocol) {
        self.consultService = consultService
        self.analyticsSerivce = analyticsService
    }
    
    var title: String = S.Consults.title
    
    func loadConsults() {
        guard let consults = consultService.fetchConsults(), !consults.isEmpty else {
            viewDelegate?.consultsViewModelShowEmptyView(animate: false)
            return
        }
        self.consults = consults
        viewDelegate?.consultsViewModel(self, didUpdateConsults: consults)
    }
    
    func getNumberOfRowsInSection() -> Int {
        consults.count
    }
    
    func getDataToCell(indexPath: IndexPath) -> CellData? {
        let consult = consults[indexPath.row]
        guard let name = consult.name, let date = consult.date else { return nil }
        
        return CellData(name: name, date: date)
    }
    
    func userEditingRow(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle) {
        if editingStyle == .delete {
            viewDelegate?.consultsViewModelShowDeleteAlert(title: S.Detail.Alert.title, message: S.Detail.Alert.message) { [weak self] in
                self?.remove(at: indexPath)
            }
        }
    }
    
    func remove(at index: IndexPath) {
        let consult = consults.remove(at: index.row)
        consultService.deleteConsult(consult: consult)
        
        viewDelegate?.consultsViewModelDeleteTableViewRow(indexPath: index)
        
        if consults.isEmpty {
            viewDelegate?.consultsViewModelShowEmptyView(animate: true)
        }
    }
    
}

// MARK: - Navigation
extension ConsultsViewModel {
    
    func newConsultSelected() {
        analyticsSerivce.logEvent(name: "ConsultsView_NewConsultSelected", params: nil)
        coordinatorDelegate?.consultsViewModelDidSelectNewConsult(self)
    }
    
    func detailSelected(indexPath: IndexPath) {
        let consult = consults[indexPath.row]
        analyticsSerivce.logEvent(name: "ConsultsView_DetailSelected", params: nil)
        coordinatorDelegate?.consultsViewModelDidSelectDetail(self, consult: consult)
    }
    
}

// MARK: - Nested type
extension ConsultsViewModel {
    
    struct CellData {
        let name: String
        let date: Date
    }
}
