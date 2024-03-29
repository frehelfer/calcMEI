//
//  ConsultsViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit
import CalcMEI_Core
import CoreData

protocol ConsultsViewModelProtocol {
    var coordinatorDelegate: ConsultsViewModelCoordinatorDelegate? { get set }
    var viewDelegate: ConsultsViewModelViewDelegate? { get set }
    
    var title: String { get }
    
    func loadConsults()
    func getNumberOfRowsInSection() -> Int
    func getDataToCell(indexPath: IndexPath) -> ConsultsViewModel.CellData?
    func userEditingRow(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle)
    
    func newConsultSelected()
    func detailSelected(indexPath: IndexPath)
}

protocol ConsultsViewModelCoordinatorDelegate: AnyObject{
    func consultsViewModelDidSelectNewConsult(_ consultsViewModel: ConsultsViewModelProtocol)
    func consultsViewModelDidSelectDetail(_ consultsViewModel: ConsultsViewModelProtocol, consult: Consult)
}

protocol ConsultsViewModelViewDelegate: AnyObject {
    func consultsViewModelWillChangeConsults()
    func consultsViewModelUpdateConsults(_ controller: NSFetchedResultsController<NSFetchRequestResult>, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    func consultsViewModelDidChangeConsults()
    func consultsViewModelShowDeleteAlert(title: String, message: String, confirmDeletePressed: @escaping () -> Void)
}

class ConsultsViewModel: NSObject, ConsultsViewModelProtocol {
    
    weak var coordinatorDelegate: ConsultsViewModelCoordinatorDelegate?
    weak var viewDelegate: ConsultsViewModelViewDelegate?
    
    private let consultService: ConsultServiceProtocol
    private let analyticsSerivce: AnalyticsServiceProtocol
    
    private var fetchedResultsController: NSFetchedResultsController<Consult>?
    
    init(consultService: ConsultServiceProtocol, analyticsService: AnalyticsServiceProtocol) {
        self.consultService = consultService
        self.analyticsSerivce = analyticsService
        self.fetchedResultsController = consultService.createFetchedResultsController()
        super.init()
        fetchedResultsController?.delegate = self
    }
    
    var title: String = S.Consults.title
    
    func loadConsults() {
        try? fetchedResultsController?.performFetch()
    }
    
    func getNumberOfRowsInSection() -> Int {
        guard let consults = fetchedResultsController?.fetchedObjects else { return 0 }
        return consults.count
    }
    
    func getDataToCell(indexPath: IndexPath) -> CellData? {
        let consult = fetchedResultsController?.object(at: indexPath)
        guard let name = consult?.name, let date = consult?.date else { return nil }
        
        return CellData(name: name, date: date)
    }
    
    func userEditingRow(indexPath: IndexPath, editingStyle: UITableViewCell.EditingStyle) {
        if editingStyle == .delete {
            viewDelegate?.consultsViewModelShowDeleteAlert(title: S.Detail.Alert.title, message: S.Detail.Alert.message) { [weak self] in
                self?.remove(at: indexPath)
            }
        }
    }
    
    private func remove(at indexPath: IndexPath) {
        guard let consult = fetchedResultsController?.object(at: indexPath) else { return }
        consultService.deleteConsult(consult: consult)
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate
extension ConsultsViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        viewDelegate?.consultsViewModelWillChangeConsults()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        viewDelegate?.consultsViewModelUpdateConsults(controller, at: indexPath, for: type, newIndexPath: newIndexPath)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        viewDelegate?.consultsViewModelDidChangeConsults()
    }
    
}

// MARK: - Navigation
extension ConsultsViewModel {
    
    func newConsultSelected() {
        analyticsSerivce.logEvent(name: "ConsultsView_NewConsultSelected", params: nil)
        coordinatorDelegate?.consultsViewModelDidSelectNewConsult(self)
    }
    
    func detailSelected(indexPath: IndexPath) {
        guard let consult = fetchedResultsController?.object(at: indexPath) else { return }
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
