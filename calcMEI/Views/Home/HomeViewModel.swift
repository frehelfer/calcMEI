//
//  HomeViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit
import CalcMEI_Core

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func homeViewModelDidSelectStart(_ homeViewModel: HomeViewModel)
    func homeViewModelDidSelectSettings(_ homeViewModel: HomeViewModel)
    func homeViewModelDidSelectConsults(_ homeViewModel: HomeViewModel)
}

class HomeViewModel {
    
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    
    private let analyticsService: AnalyticsServiceProtocol
    
    init(analyticsService: AnalyticsServiceProtocol) {
        self.analyticsService = analyticsService
    }
    
    var title: String = S.Home.title
}

// MARK: - Navigation
extension HomeViewModel {
    
    func startSelected() {
        analyticsService.logEvent(name: "HomeView_StartSelected", params: nil)
        coordinatorDelegate?.homeViewModelDidSelectStart(self)
    }
    
    func settingsSelected() {
        analyticsService.logEvent(name: "HomeView_SettingsSelected", params: nil)
        coordinatorDelegate?.homeViewModelDidSelectSettings(self)
    }
    
    func consultsSelected() {
        analyticsService.logEvent(name: "HomeView_ConsultsSelected", params: nil)
        coordinatorDelegate?.homeViewModelDidSelectConsults(self)
    }
    
    func openUrl(url: URL) {
        analyticsService.logEvent(name: "HomeView_InstruçãoNormativaSelected", params: nil)
        UIApplication.shared.open(url)
    }
    
}
