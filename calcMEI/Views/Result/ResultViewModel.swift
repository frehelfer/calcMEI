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
    
    private var count: Count
    
    init(count: Count) {
        self.count = count
    }
    
    var title: String = S.Result.title
    
    func updateViewWithCount() {
        calculateAll()
        viewDelegate?.resultViewModel(self, updateViewWithCount: count)
    }
}

// TODO: Mudar nome das funções pro ingreis?
// MARK: - Calculation
extension ResultViewModel {
    
    func calculateAll() {
        count.receitaBrutaAnual = calculateReceitaBrutaAnual(count)
        count.lucroApurado = calculateLucroApurado(count)
        count.rendimentoIsento = calculateRendimentoIsento(count)
        count.rendimentoTributavel = calculateRendimentoTributavel(count)
        count.hasToDeclare = hasToDeclare(count)
    }
    
    private func calculateReceitaBrutaAnual(_ count: Count) -> Double {
        count.inServiceProvision + count.inCommerce + count.inPassengerTransport
    }
    
    private func calculateLucroApurado(_ count: Count) -> Double {
        count.receitaBrutaAnual - count.outExpenses
    }
    
    private func calculateRendimentoIsento(_ count: Count) -> Double {
        let rendimentoIsentoServicos = count.inServiceProvision * Configuration.rendimentoIsentoServico
        let rendimentoIsentoComercio = count.inCommerce * Configuration.rendimentoIsentoComercio
        let rendimentoIsentoTransporte = count.inPassengerTransport * Configuration.rendimentoIsentoTransporte
        
        return rendimentoIsentoServicos + rendimentoIsentoComercio + rendimentoIsentoTransporte
    }
    
    private func calculateRendimentoTributavel(_ count: Count) -> Double {
        count.lucroApurado - count.rendimentoIsento
    }
    
    private func hasToDeclare(_ count: Count) -> Bool {
        count.rendimentoTributavel > Configuration.rendimentoTributavelLimite
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
