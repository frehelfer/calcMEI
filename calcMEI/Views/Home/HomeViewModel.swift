//
//  HomeViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func homeViewModelDidSelectStart(_ homeViewModel: HomeViewModel)
    func homeViewModelDidSelectSettings(_ homeViewModel: HomeViewModel)
    func homeViewModelDidSelectConsults(_ homeViewModel: HomeViewModel)
}

class HomeViewModel {
    
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    
    init() {
        
    }
    
    var title: String = S.Home.title
}

// MARK: - Navigation
extension HomeViewModel {
    
    func startSelected() {
        coordinatorDelegate?.homeViewModelDidSelectStart(self)
    }
    
    func settingsSelected() {
        coordinatorDelegate?.homeViewModelDidSelectSettings(self)
    }
    
    func consultsSelected() {
        coordinatorDelegate?.homeViewModelDidSelectConsults(self)
    }
    
}
