//
//  IncomeViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit

protocol IncomeViewModelCoordinatorDelegate: AnyObject {
    func incomeViewModelDidSelectNext(_ incomeViewModel: IncomeViewModel)
}

protocol IncomeViewModelViewDelegate: AnyObject {
    
}

class IncomeViewModel {
    
    weak var coordinatorDelegate: IncomeViewModelCoordinatorDelegate?
    weak var viewDelegate: IncomeViewModelViewDelegate?
    
    init() {
        
    }
    
    var title: String {
        return "Receita Bruta Anual"
    }
}

// MARK: - Navigation
extension IncomeViewModel {
    
    func nextSelected() {
        coordinatorDelegate?.incomeViewModelDidSelectNext(self)
    }
    
}
