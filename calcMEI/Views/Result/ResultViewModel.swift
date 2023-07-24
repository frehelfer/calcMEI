//
//  ResultViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 17/02/23.
//

import UIKit
import CalcMEI_Core

protocol ResultViewModelProtocol {
    var coordinatorDelegate: ResultViewModelCoordinatorDelegate? { get set }
    var viewDelegate: ResultViewModelViewDelegate? { get set }
    
    var resultItems: [ResultItem] { get set }
    var title: String { get set }
    
    func updateViewWithCount()
    func didSelectRow(indexPath: IndexPath)
    
    func calculateAll()
    
    func resetSelected()
    func saveConsultSelected(_ text: String)
    func backButtonPressed()
}

protocol ResultViewModelCoordinatorDelegate: AnyObject {
    func resultViewModelDidSelectReset(_ resultViewModel: ResultViewModelProtocol)
    func resultViewModelDidSelectItemDetail(_ resultViewModel: ResultViewModelProtocol, resultItem: ResultItem)
}

protocol ResultViewModelViewDelegate: AnyObject {
    func resultViewModel(_ resultViewMode: ResultViewModelProtocol, updateViewWithCount: [ResultItem])
}

class ResultViewModel: ResultViewModelProtocol {
    
    weak var coordinatorDelegate: ResultViewModelCoordinatorDelegate?
    weak var viewDelegate: ResultViewModelViewDelegate?
    
    private var count: Count
    private let consultService: ConsultServiceProtocol
    private let analyticsService: AnalyticsServiceProtocol

    init(count: Count, consultService: ConsultServiceProtocol, analyticsService: AnalyticsServiceProtocol) {
        self.count = count
        self.consultService = consultService
        self.analyticsService = analyticsService
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
                title: "Precisa Declarar?",
                result: count.hasToDeclare ? "Sim" : "Não",
                resultColor: count.hasToDeclare ? A.Colors.red.color : A.Colors.green.color,
                description: """
                Se você recebeu outros valores como Pessoa Física e a soma desses valores juntamente com o Rendimento Tributável ultrapassou o limite de \(Configuration.rendimentoTributavelLimite.currencyFormatFromDouble()), será necessário fazer a Declaração de Imposto de Renda de Pessoa Física (IRPF).
                
                A declaração deve ser realizada por meio do software disponibilizado pela Receita Federal. É necessário acessar o software e preencher duas fichas de declaração: "Rendimentos isentos e não tributáveis" e "Rendimentos tributáveis recebidos de pessoa jurídica". Nessas fichas, você deverá inserir a parcela isenta do lucro e o lucro tributável, respectivamente.
                """
            ),
            ResultItem(
                title: "Receita Bruta Anual",
                result: count.receitaBrutaAnual.currencyFormatFromDouble(),
                description: "A Receita Bruta Anual representa a soma de todos os valores recebidos ao longo do ano."
            ),
            ResultItem(
                title: "Lucro Apurado",
                result: count.lucroApurado.currencyFormatFromDouble(),
                description: "O Lucro Apurado é o montante remanescente após subtrair todos os gastos e custos necessários para gerar a receita do período considerado. É a Receita Bruta menos as despesas do ano."
            ),
            ResultItem(
                title: "Rendimento Isento",
                result: count.rendimentoIsento.currencyFormatFromDouble(),
                resultColor: count.rendimentoIsento > 0 ? A.Colors.green.color : nil,
                description: """
                Para cada categoria de MEI, existe uma parcela isenta de tributação conforme as seguintes porcentagens:

                - Prestação de Serviços: \(Configuration.rendimentoIsentoServico * 100)%.
                - Comércio, Indústria e Transporte de Cargas: \(Configuration.rendimentoIsentoComercio * 100)%.
                - Transporte de Passageiros: \(Configuration.rendimentoIsentoTransporte * 100)%.
                """
            ),
            ResultItem(
                title: "Rendimento Tributável",
                result: count.rendimentoTributavel.currencyFormatFromDouble(),
                resultColor: count.rendimentoTributavel > 0 ? count.rendimentoTributavel > Configuration.rendimentoTributavelLimite ? A.Colors.red.color : A.Colors.green.color : nil,
                description: """
                O Rendimento Tributável é o valor utilizado para determinar se você está sujeito ao pagamento do Imposto de Renda Pessoa Física. Para calcular esse valor, é necessário subtrair o Rendimento Isento do Lucro Apurado.

                Caso o resultado seja superior a \(Configuration.rendimentoTributavelLimite.currencyFormatFromDouble()), é obrigatória a declaração do Imposto de Renda Pessoa Física (IRPF).
                """
            )
        ]
        
        resultItems = data
    }
    
    func didSelectRow(indexPath: IndexPath) {
        let selected = resultItems[indexPath.row]
        
        analyticsService.logEvent(name: "ResultView_DidSelectRow", params: ["row" : "\(selected.title)"])
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
        analyticsService.logEvent(name: "ResultView_RestartSelected", params: nil)
        coordinatorDelegate?.resultViewModelDidSelectReset(self)
    }
    
    func saveConsultSelected(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        count.name = trimmed
        consultService.createConsult(count: count)
        
        analyticsService.logEvent(name: "ResultView_SaveConsultSelected", params: nil)
        coordinatorDelegate?.resultViewModelDidSelectReset(self)
    }
    
    func backButtonPressed() {
        analyticsService.logEvent(name: "ResultView_BackButtonSelected", params: nil)
    }
    
}

// MARK: - Nested Type

struct ResultItem {
    var title: String
    var result: String
    var resultColor: UIColor? = nil
    var description: String? = nil
    var backgroundColor: UIColor? = nil
}
