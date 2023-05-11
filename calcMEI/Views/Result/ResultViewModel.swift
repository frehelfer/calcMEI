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
    func resultViewModelDidSelectItemDetail(_ resultViewModel: ResultViewModel, resultItem: ResultViewModel.ResultItem)
}

protocol ResultViewModelViewDelegate: AnyObject {
    func resultViewModel(_ resultViewMode: ResultViewModel, updateViewWithCount: [ResultViewModel.ResultItem])
}

class ResultViewModel {
    
    weak var coordinatorDelegate: ResultViewModelCoordinatorDelegate?
    weak var viewDelegate: ResultViewModelViewDelegate?
    
    private let consultService: ConsultServiceProtocol
    private var count: Count

    init(count: Count, consultService: ConsultServiceProtocol) {
        self.count = count
        self.consultService = consultService
    }
    
    var resultItems: [ResultItem] = [] {
        didSet {
            viewDelegate?.resultViewModel(self, updateViewWithCount: resultItems)
        }
    }
    
    var title: String = S.Result.title
    
    func updateViewWithCount() {
        calculateAll()
        
        let data = [
            ResultItem(
                title: "Precisa Declarar:",
                result: count.hasToDeclare ? "Sim" : "Não",
                resultColor: count.hasToDeclare ? A.Colors.red.color : A.Colors.green.color,
                description: "a"
            ),
            ResultItem(
                title: "Receita Bruta Anual:",
                result: count.receitaBrutaAnual.currencyFormatFromDouble(),
                description: "a"
            ),
            ResultItem(
                title: "Lucro Apurado:",
                result: count.lucroApurado.currencyFormatFromDouble(),
                description: "a"
            ),
            ResultItem(
                title: "Rendimento Isento:",
                result: count.rendimentoIsento.currencyFormatFromDouble(),
                resultColor: count.rendimentoIsento > 0 ? A.Colors.green.color : nil,
                description: "a"
            ),
            ResultItem(
                title: "Rendimento Tributável:",
                result: count.rendimentoTributavel.currencyFormatFromDouble(),
                resultColor: count.rendimentoTributavel > 0 ? count.rendimentoTributavel > Configuration.rendimentoTributavelLimite ? A.Colors.red.color : A.Colors.green.color : nil,
                description: "a"
            )
        ]
        
        resultItems = data
    }
    
    func didSelectRow(indexPath: IndexPath) {
        let selected = resultItems[indexPath.row]
        coordinatorDelegate?.resultViewModelDidSelectItemDetail(self, resultItem: selected)
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
    
    func saveConsultSelected(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        count.name = trimmed
        consultService.createConsult(count: count)
        coordinatorDelegate?.resultViewModelDidSelectReset(self)
    }
    
}

// MARK: - Nested Type
extension ResultViewModel {
    
    struct ResultItem {
        var title: String
        var result: String
        var resultColor: UIColor? = nil
        var description: String? = nil
    }
    
}
