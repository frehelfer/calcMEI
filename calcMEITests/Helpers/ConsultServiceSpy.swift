//
//  ConsultServiceSpy.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 28/03/23.
//

import Foundation
@testable import calcMEI

class ConsultServiceSpy: ConsultService {
    enum Methods {
        case createConsult
        case deleteConsult
        case fetchConsults
    }
    
    var calledMethods: [Methods] = []
    
    func createConsult(count: calcMEI.Count) {
        calledMethods.append(.createConsult)
    }
    
    func deleteConsult(consult: calcMEI.Consult) {
        calledMethods.append(.deleteConsult)
    }
    
    func fetchConsults() -> [calcMEI.Consult]? {
        calledMethods.append(.fetchConsults)
        return nil
    }

}
