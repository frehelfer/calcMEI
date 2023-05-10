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
    func resultViewModel(_ resultViewMode: ResultViewModel, updateViewWithCount: [ResultViewModel.NestedResult])
}

class ResultViewModel {
    
    weak var coordinatorDelegate: ResultViewModelCoordinatorDelegate?
    weak var viewDelegate: ResultViewModelViewDelegate?
    
    private var count: Count
    var data: [NestedResult] = []
    
    init(count: Count) {
        self.count = count
    }
    
    var title: String = S.Result.title
    
    func updateViewWithCount() {
        calculateAll()
        
        for i in 0..<5 {
            var new = NestedResult()
            switch i {
            case 0:
                new.title = "Precisa Declarar:"
                new.result = count.hasToDeclare ? "Sim" : "Não"
                new.resultColor = count.hasToDeclare ? A.Colors.red.color : A.Colors.green.color
            case 1:
                new.title = "Receita Bruta Anual:"
                new.result = count.receitaBrutaAnual.currencyFormatFromDouble()
            case 2:
                new.title = "Lucro Apurado:"
                new.result = count.lucroApurado.currencyFormatFromDouble()
            case 3:
                new.title = "Rendimento Isento:"
                new.result = count.rendimentoIsento.currencyFormatFromDouble()
                new.resultColor = count.rendimentoIsento > 0 ? A.Colors.green.color : nil
            case 4:
                new.title = "Rendimento Tributável:"
                new.result = count.rendimentoTributavel.currencyFormatFromDouble()
                new.resultColor = count.rendimentoTributavel > 0 ? count.rendimentoTributavel > Configuration.rendimentoTributavelLimite ? A.Colors.red.color : A.Colors.green.color : nil
            default:
                break
            }
            
            data.append(new)
        }
        
        viewDelegate?.resultViewModel(self, updateViewWithCount: data)
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

// MARK: - Nested Type
extension ResultViewModel {
    
    struct NestedResult {
        var title: String? = nil
        var result: String? = nil
        var resultColor: UIColor? = nil
    }
    
}
