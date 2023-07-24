//
//  DetailsScreen_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 24/07/23.
//

import XCTest
import SnapshotTesting
@testable import calcMEI

final class DetailScreen_SnapShotTests: XCTestCase {

    func test_DetailViewController_withoutData() {
        let vc = DetailViewController()
        let nav = UINavigationController(rootViewController: vc)
        assertSnapshot(matching: nav, as: .image)
    }
    
    func test_SettingsViewController_withData() {
        let vc = DetailViewController()
        let viewModel = DetailViewModelMock()
        viewModel.viewDelegate = vc
        vc.viewModel = viewModel
        
        let nav = UINavigationController(rootViewController: vc)
        assertSnapshot(matching: nav, as: .image)
    }
    
}

private extension DetailScreen_SnapShotTests {
    
    class DetailViewModelMock: DetailViewModelProtocol {
        var coordinatorDelegate: DetailViewModelCoordinatorDelegate?
        var viewDelegate: DetailViewModelViewDelegate?
        
        init() {
            
        }
        
        var resultItems: [DetailViewModel.ItemsGroup] = []
        var title: String = "Consulta"
        
        func deleteSelected() {
            // don't need
        }
        
        func updateViewWithData() {
            let data = [
                DetailViewModel.ItemsGroup(title: "Receitas e Despesas", items: [
                    ResultItem(
                        title: "Prestação de Serviços",
                        result: "R$ 0,00",
                        backgroundColor: A.Colors.green50.color
                    ),
                    ResultItem(
                        title: "Comércio e Indústria",
                        result: "R$ 0,00",
                        backgroundColor: A.Colors.green50.color
                    ),
                    ResultItem(
                        title: "Trans. de Passageiros",
                        result: "R$ 0,00",
                        backgroundColor: A.Colors.green50.color
                    ),
                    ResultItem(
                        title: "Despesas",
                        result: "R$ 0,00",
                        backgroundColor: A.Colors.red50.color
                    )
                ]),
                DetailViewModel.ItemsGroup(title: "Resultado", items: [
                    ResultItem(
                        title: "Precisa Declarar",
                        result: "Não",
                        resultColor: A.Colors.green.color
                    ),
                    ResultItem(
                        title: "Receita Bruta Anual",
                        result: "R$ 0,00"
                    ),
                    ResultItem(
                        title: "Lucro Apurado",
                        result: "R$ 0,00"
                    ),
                    ResultItem(
                        title: "Rendimento Isento",
                        result: "R$ 0,00",
                        resultColor: nil
                    ),
                    ResultItem(
                        title: "Rendimento Tributável",
                        result: "R$ 0,00",
                        resultColor: nil
                    )
                ])
            ]
            
            resultItems = data
        }
        
        
    }
}
