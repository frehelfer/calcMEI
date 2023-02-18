//
//  ResultViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit

protocol ResultViewModelCoordinatorDelegate: AnyObject {
    func resultViewModelDidSelectReset(_ resultViewModel: ResultViewModel)
}

protocol ResultViewModelViewDelegate: AnyObject {
    
}

class ResultViewModel {
    
    weak var coordinatorDelegate: ResultViewModelCoordinatorDelegate?
    weak var viewDelegate: ResultViewModelViewDelegate?
    
    init() {
        
    }
    
    var title: String {
        return "Resultado"
    }
}

// MARK: - Navigation
extension ResultViewModel {
    
    func resetSelected() {
        coordinatorDelegate?.resultViewModelDidSelectReset(self)
    }
    
}
