//
//  ExpensesViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit
import CalcMEI_Core

protocol ExpensesViewModelCoordinatorDelegate: AnyObject {
    func expensesViewModelDidSelectNext(_ expensesViewModel: ExpensesViewModel, count: Count)
}

class ExpensesViewModel {
    
    weak var coordinatorDelegate: ExpensesViewModelCoordinatorDelegate?
    
    var count: Count
    
    init(count: Count) {
        self.count = count
    }
    
    var title: String = S.Expenses.title
    
    func updateCount(expenses: Double) {
        self.count.outExpenses = expenses
    }
}

// MARK: - Navigation
extension ExpensesViewModel {
    
    func nextSelected() {
        coordinatorDelegate?.expensesViewModelDidSelectNext(self, count: self.count)
    }
    
}
