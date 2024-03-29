//
//  ConsultServiceSpy.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 28/03/23.
//

import Foundation
import CalcMEI_Core
import CoreData

class ConsultServiceSpy: ConsultServiceProtocol {
    
    enum Methods {
        case createFetchedResultsController
        case createConsult
        case deleteConsult
        case fetchConsults
    }
    
    var calledMethods: [Methods] = []
    
    func createFetchedResultsController() -> NSFetchedResultsController<Consult>? {
        calledMethods.append(.createFetchedResultsController)
        return nil
    }
    
    func createConsult(count: Count) {
        calledMethods.append(.createConsult)
    }
    
    func deleteConsult(consult: Consult) {
        calledMethods.append(.deleteConsult)
    }
    
    func fetchConsults() -> [Consult]? {
        calledMethods.append(.fetchConsults)
        return nil
    }

}
