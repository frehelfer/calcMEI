//
//  CalcMEI_SDK.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import Foundation

class CalcMEI_SDK {
    
    // Persistence
    private lazy var coreDataManager: CoreDataManaging = {
        return CoreDataManager()
    }()
    
    // Public Services
    public var consultService: ConsultService {
        return LocalConsultService(
            coreDataManager: self.coreDataManager
        )
    }
    
}
