//
//  ExpensesViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit

protocol ExpensesViewModelCoordinatorDelegate: AnyObject {
    func expensesViewModelDidSelectNext(_ expensesViewModel: ExpensesViewModel)
}

protocol ExpensesViewModelViewDelegate: AnyObject {
    
}

class ExpensesViewModel {
    
    weak var coordinatorDelegate: ExpensesViewModelCoordinatorDelegate?
    weak var viewDelegate: ExpensesViewModelViewDelegate?
    
    init() {
        
    }
    
    var title: String {
        return "Despesas Anuais"
    }
}

// MARK: - Navigation
extension ExpensesViewModel {
    
    func nextSelected() {
        coordinatorDelegate?.expensesViewModelDidSelectNext(self)
    }
    
}
