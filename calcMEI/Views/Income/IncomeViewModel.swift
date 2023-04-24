//
//  IncomeViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit
import CalcMEI_Core

protocol IncomeViewModelCoordinatorDelegate: AnyObject {
    func incomeViewModelDidSelectNext(_ incomeViewModel: IncomeViewModel, count: Count)
}

class IncomeViewModel {
    
    weak var coordinatorDelegate: IncomeViewModelCoordinatorDelegate?
    
    init() {
        
    }
    
    var title: String = S.Income.title
}

// MARK: - Navigation
extension IncomeViewModel {
    
    func nextSelected(incomeData: IncomeData) {
        
        let count = Count(
            inServiceProvision: incomeData.inServiceProvision,
            inCommerce: incomeData.inCommerce,
            inPassengerTransport: incomeData.inPassengerTransport
        )
        
        coordinatorDelegate?.incomeViewModelDidSelectNext(self, count: count)
    }
    
}

// MARK: - Nested Type
extension IncomeViewModel {
    
    struct IncomeData {
        let inServiceProvision: Double
        let inCommerce: Double
        let inPassengerTransport: Double
    }
    
}
