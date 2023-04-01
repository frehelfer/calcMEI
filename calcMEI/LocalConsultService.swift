//
//  ConsultService.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import Foundation
import CoreData

protocol ConsultService {
    func createConsult(count: Count)
    func deleteConsult(consult: Consult)
    func fetchConsults() -> [Consult]?
}

class LocalConsultService: ConsultService {
    
    private let coreDataManager: CoreDataManaging
    
    init(coreDataManager: CoreDataManaging) {
        self.coreDataManager = coreDataManager
    }
    
    func createConsult(count: Count) {
        let newConsult = Consult(context: coreDataManager.viewContext)
        newConsult.id = count.id
        newConsult.name = count.name
        newConsult.hasToDeclare = count.hasToDeclare
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
        print(#function)
    }
    
    func deleteConsult(consult: Consult) {
        let context = coreDataManager.viewContext
        
        context.delete(consult)
        
        coreDataManager.saveContext()
        print(#function)
    }
    
    func fetchConsults() -> [Consult]? {
        if let consults = coreDataManager.perform(fetchRequest: allConsults) {
            print(#function)
            return consults
        }
        
        return nil
    }
    
}

// MARK: - Fetch Requests
private extension LocalConsultService {

    var allConsults: NSFetchRequest<Consult> {
        let fetchRequest: NSFetchRequest<Consult> = Consult.fetchRequest()
        return fetchRequest
    }
    
}
