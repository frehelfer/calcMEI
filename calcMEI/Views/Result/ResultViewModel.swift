//
//  ResultViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit
import CalcMEI_Core

protocol ResultViewModelCoordinatorDelegate: AnyObject {
    func resultViewModelDidSelectReset(_ resultViewModel: ResultViewModel)
    func resultViewModelDidSelectSaveConsult(_ resultViewModel: ResultViewModel, count: Count)
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
    
    var title: String = S.Result.title
    
    func updateViewWithCount() {
        viewDelegate?.resultViewModel(self, updateViewWithCount: count)
    }
}

// MARK: - Navigation
extension ResultViewModel {
    
    func resetSelected() {
        coordinatorDelegate?.resultViewModelDidSelectReset(self)
    }
    
    func saveConsultSelected() {
        coordinatorDelegate?.resultViewModelDidSelectSaveConsult(self, count: count)
    }
    
}
