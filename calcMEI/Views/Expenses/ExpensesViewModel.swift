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
    
    private(set) var count: Count
    private let analyticsService: AnalyticsServiceProtocol
    
    init(count: Count, analyticsService: AnalyticsServiceProtocol) {
        self.count = count
        self.analyticsService = analyticsService
    }
    
    var title: String = S.Expenses.title
    
    func updateCount(expenses: Double) {
        self.count.outExpenses = expenses
    }
}

// MARK: - Navigation
extension ExpensesViewModel {
    
    private func nextSelected() {
        coordinatorDelegate?.expensesViewModelDidSelectNext(self, count: self.count)
    }
    
    func nextBottomButtonSelected() {
        analyticsService.logEvent(name: "ExpensesView_ResultBottomButtonSelected", params: nil)
        nextSelected()
    }
    
    func nextNavButtonSelected() {
        analyticsService.logEvent(name: "ExpensesView_ResultNavButtonSelected", params: nil)
        nextSelected()
    }
    
    func backButtonSelected() {
        analyticsService.logEvent(name: "ExpensesView_BackButtonSelected", params: nil)
    }
}
