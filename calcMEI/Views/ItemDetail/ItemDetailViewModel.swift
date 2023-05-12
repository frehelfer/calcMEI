//
//  SaveConsultViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import Foundation
import CalcMEI_Core

protocol ItemDetailViewModelViewDelegate: AnyObject {
    func itemDetailViewModel(_ itemDetailViewModel: ItemDetailViewModel, updateViewWithData: ResultItem)
}

class ItemDetailViewModel {

    weak var viewDelegate: ItemDetailViewModelViewDelegate?

    var itemDetail: ResultItem
    
    init(itemDetail: ResultItem) {
        self.itemDetail = itemDetail
    }
    
    var title: String {
        itemDetail.title
    }
    
    func updateViewWithData() {
        viewDelegate?.itemDetailViewModel(self, updateViewWithData: itemDetail)
    }
}
