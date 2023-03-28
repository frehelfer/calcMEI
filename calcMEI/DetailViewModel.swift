//
//  DetailViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import Foundation

protocol DetailViewModelViewDelegate: AnyObject {
    
}

class DetailViewModel {

    weak var viewDelegate: DetailViewModelViewDelegate?
    
    private let consultService: ConsultService
    
    let consult: Consult
    
    init(consultService: ConsultService, consult: Consult) {
        self.consultService = consultService
        self.consult = consult
    }
    
    var title: String {
        consult.name ?? ""
    }
    
}
