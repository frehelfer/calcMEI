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
    
    private let analyticsService: AnalyticsServiceProtocol
    
    init(analyticsService: AnalyticsServiceProtocol) {
        self.analyticsService = analyticsService
    }
    
    var title: String = S.Income.title
}

// MARK: - Navigation
extension IncomeViewModel {
    
    private func nextSelected(incomeData: IncomeData) {
        
        let count = Count(
            inServiceProvision: incomeData.inServiceProvision,
            inCommerce: incomeData.inCommerce,
            inPassengerTransport: incomeData.inPassengerTransport
        )
        
        coordinatorDelegate?.incomeViewModelDidSelectNext(self, count: count)
    }
    
    func nextBottomButtonSelected(incomeData: IncomeData) {
        analyticsService.logEvent(name: "IncomeView_NextBottomButtonSelected", params: nil)
        nextSelected(incomeData: incomeData)
    }
    
    func nextNavButtonSelected(incomeData: IncomeData) {
        analyticsService.logEvent(name: "IncomeView_NextNavButtonSelected", params: nil)
        nextSelected(incomeData: incomeData)
    }
    
    func backButtonSelected() {
        analyticsService.logEvent(name: "IncomeView_BackButtonSelected", params: nil)
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
