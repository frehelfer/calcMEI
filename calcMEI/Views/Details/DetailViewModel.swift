//
//  DetailViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import Foundation
import CalcMEI_Core

protocol DetailViewModelCoordinatorDelegate: AnyObject {
    func detailViewModelDidSelectDismiss(_ detailViewModel: DetailViewModel)
    func detailViewModelDidSelectItemDetail(_ detailViewModel: DetailViewModel, resultItem: ResultItem)
}

protocol DetailViewModelViewDelegate: AnyObject {
    func detailViewModel(_ detailViewModel: DetailViewModel, updateViewWithItem: [DetailViewModel.ItemsGroup])
}

class DetailViewModel {

    weak var coordinatorDelegate: DetailViewModelCoordinatorDelegate?
    weak var viewDelegate: DetailViewModelViewDelegate?
    
    private let consultService: ConsultServiceProtocol
    
    private let consult: Consult
    
    init(consultService: ConsultServiceProtocol, consult: Consult) {
        self.consultService = consultService
        self.consult = consult
    }
    
    var resultItems: [ItemsGroup] = [] {
        didSet {
            viewDelegate?.detailViewModel(self, updateViewWithItem: resultItems)
        }
    }
    
    var title: String {
        consult.name ?? ""
    }
    
    func deleteSelected() {
        consultService.deleteConsult(consult: consult)
        coordinatorDelegate?.detailViewModelDidSelectDismiss(self)
    }
    
    func updateViewWithData() {
        let data = [
            ItemsGroup(title: "Receitas e Despesas", items: [
                ResultItem(
                    title: "Prestação de Serviços",
                    result: consult.inServiceProvision.currencyFormatFromDouble(),
                    backgroundColor: A.Colors.green50.color
                ),
                ResultItem(
                    title: "Comércio e Indústria",
                    result: consult.inCommerce.currencyFormatFromDouble(),
                    backgroundColor: A.Colors.green50.color
                ),
                ResultItem(
                    title: "Trans. de Passageiros",
                    result: consult.inPassengerTransport.currencyFormatFromDouble(),
                    backgroundColor: A.Colors.green50.color
                ),
                ResultItem(
                    title: "Despesas",
                    result: consult.outExpenses.currencyFormatFromDouble(),
                    backgroundColor: A.Colors.red50.color
                )
            ]),
            ItemsGroup(title: "Resultado", items: [
                ResultItem(
                    title: "Precisa Declarar",
                    result: consult.hasToDeclare ? "Sim" : "Não",
                    resultColor: consult.hasToDeclare ? A.Colors.red.color : A.Colors.green.color
                ),
                ResultItem(
                    title: "Receita Bruta Anual",
                    result: consult.receitaBrutaAnual.currencyFormatFromDouble()
                ),
                ResultItem(
                    title: "Lucro Apurado",
                    result: consult.lucroApurado.currencyFormatFromDouble()
                ),
                ResultItem(
                    title: "Rendimento Isento",
                    result: consult.rendimentoIsento.currencyFormatFromDouble(),
                    resultColor: consult.rendimentoIsento > 0 ? A.Colors.green.color : nil
                ),
                ResultItem(
                    title: "Rendimento Tributável",
                    result: consult.rendimentoTributavel.currencyFormatFromDouble(),
                    resultColor: consult.rendimentoTributavel > 0 ? consult.rendimentoTributavel > Configuration.rendimentoTributavelLimite ? A.Colors.red.color : A.Colors.green.color : nil
                )
            ])
        ]
        
        resultItems = data
    }
    
}
// MARK: - Nested type
extension DetailViewModel {
    
    struct ItemsGroup {
        let title: String
        let items: [ResultItem]
    }
}
