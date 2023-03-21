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
}

protocol HomeViewModelViewDelegate: AnyObject {
//    func homeViewModel(_ homeViewModel: HomeViewModel, didReceiveError error: Error)
}

class HomeViewModel {
    
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var viewDelegate: HomeViewModelViewDelegate?
    
    init() {
        
    }
    
    var title: String {
        return "calcMEI"
    }
}

// MARK: - Navigation
extension HomeViewModel {
    
    func startSelected() {
        coordinatorDelegate?.homeViewModelDidSelectStart(self)
    }
    
    func settingsSelected() {
        coordinatorDelegate?.homeViewModelDidSelectSettings(self)
    }
    
}
