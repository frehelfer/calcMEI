//
//  ResultScreen_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 22/07/23.
//

import XCTest
import SnapshotTesting
import CalcMEI_Core
@testable import calcMEI

class ResultScreen_SnapShotTests: XCTestCase {
    
    func test_ResultViewController_withoutData() {
        let vc = ResultViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        assertSnapshot(matching: nav, as: .image(precision: 0.99))
    }
    
    func test_ResultViewController_withData() {
        let vc = ResultViewController()
        vc.viewModel = ResultViewModelMock()
        let nav = UINavigationController(rootViewController: vc)
        
        assertSnapshot(matching: nav, as: .image(precision: 0.99))
    }
    
    func test_ResultTableViewCell_default() {
        let view = ResultTableViewCell(frame: CGRect(x: 0, y: 0, width: 400, height: 55))
        let data = ResultItem(title: "Teste", result: "R$ 0,00", resultColor: nil, description: nil, backgroundColor: nil)
        
        view.setupCell(data: data)
        
        assertSnapshot(matching: view, as: .image(precision: 0.99))
    }
    
    func test_ResultTableViewCell_green() {
        let view = ResultTableViewCell(frame: CGRect(x: 0, y: 0, width: 400, height: 55))
        let data = ResultItem(title: "Teste", result: "R$ 100,00", resultColor: A.Colors.green.color, description: nil, backgroundColor: nil)
        
        view.setupCell(data: data)
        
        assertSnapshot(matching: view, as: .image(precision: 0.99))
    }
    
    func test_ResultTableViewCell_red() {
        let view = ResultTableViewCell(frame: CGRect(x: 0, y: 0, width: 400, height: 55))
        let data = ResultItem(title: "Teste", result: "R$ 30.000,00", resultColor: A.Colors.red.color, description: nil, backgroundColor: nil)
        
        view.setupCell(data: data)
        
        assertSnapshot(matching: view, as: .image(precision: 0.99))
    }
    
}

private extension ResultScreen_SnapShotTests {
    
    class ResultViewModelMock: ResultViewModelProtocol {
        weak var coordinatorDelegate: ResultViewModelCoordinatorDelegate?
        weak var viewDelegate: ResultViewModelViewDelegate?
        
        var count = Count()
        
        var resultItems: [ResultItem] = []
        var title: String = "Resultado"
        
        func updateViewWithCount() {
            
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
                    result: "R$ 0,00",
                    description: "A Receita Bruta Anual representa a soma de todos os valores recebidos ao longo do ano."
                ),
                ResultItem(
                    title: "Lucro Apurado",
                    result: "R$ 0,00",
                    description: "O Lucro Apurado é o montante remanescente após subtrair todos os gastos e custos necessários para gerar a receita do período considerado. É a Receita Bruta menos as despesas do ano."
                ),
                ResultItem(
                    title: "Rendimento Isento",
                    result: "R$ 0,00",
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
                    result: "R$ 0,00",
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
            // don't need
        }
        
        func calculateAll() {
            // don't need
        }
        
        func resetSelected() {
            // don't need
        }
        
        func saveConsultSelected(_ text: String) {
            // don't need
        }
        
        func backButtonPressed() {
            // don't need
        }
        
    }
}
