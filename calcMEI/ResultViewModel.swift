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
    func resultViewModel(_ resultViewMode: ResultViewModel, updateViewWithCount: Count)
}

class ResultViewModel {
    
    weak var coordinatorDelegate: ResultViewModelCoordinatorDelegate?
    weak var viewDelegate: ResultViewModelViewDelegate?
    
    var count: Count
    
    init(count: Count) {
        self.count = count
    }
    
    var title: String {
        return "Resultado"
    }
    
    public func updateViewWithCount() {
        viewDelegate?.resultViewModel(self, updateViewWithCount: count)
    }
}

// MARK: - Navigation
extension ResultViewModel {
    
    func resetSelected() {
        coordinatorDelegate?.resultViewModelDidSelectReset(self)
    }
    
}
