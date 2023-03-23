//
//  ConsultService.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import Foundation
import CoreData

public protocol ConsultService {
    
}

class LocalConsultService: ConsultService {
    
    private let coreDataManager: CoreDataManaging
    
    init(coreDataManager: CoreDataManaging) {
        self.coreDataManager = coreDataManager
    }
    
    func addNewConsult(count: Count, name: String, hasToDeclare: Bool) {
        let newConsult = Consult(context: coreDataManager.viewContext)
        newConsult.id = count.id
        newConsult.name = name
        newConsult.hasToDeclare = hasToDeclare
        newConsult.date = count.date
        newConsult.inServiceProvision = count.inServiceProvision
        newConsult.inCommerce = count.inCommerce
        newConsult.inPassengerTransport = count.inPassengerTransport
        newConsult.outExpenses = count.outExpenses
        newConsult.receitaBrutaAnual = count.receitaBrutaAnual
        newConsult.lucroApurado = count.lucroApurado
        newConsult.rendimentoIsento = count.rendimentoIsento
        newConsult.rendimentoTributavel = count.rendimentoTributável
        
        coreDataManager.saveContext()
    }
    
    func deleteConsult(consult: Consult) {
        let context = coreDataManager.viewContext
        
        context.delete(consult)
        
        coreDataManager.saveContext()
    }
    
    // DOnt need it? I can fetch directly in the array, in the view model.
//    func fetchConsults(completion: () -> [Consult]?) {
//        guard let consults = coreDataManager.perform(fetchRequest: allConsults) else { return }
//
//    }
    
    // later maybe?
//    func updateConsult() {
//
//    }
}

// MARK: - Fetch Requests
extension LocalConsultService {
    
    var allConsults: NSFetchRequest<Consult> {
        let fetchRequest: NSFetchRequest<Consult> = Consult.fetchRequest()
        return fetchRequest
    }
}
