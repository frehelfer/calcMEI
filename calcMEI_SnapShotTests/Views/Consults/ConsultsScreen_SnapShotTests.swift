//
//  ConsultsScreen_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 22/07/23.
//

import XCTest
import SnapshotTesting
import CalcMEI_Core
@testable import calcMEI

class ConsultsScreen_SnapShotTests: XCTestCase {
    
    override class func setUp() {
        isRecording = false
    }
    
    func test_ConsultsViewController_withData() {
        let vc = ConsultsViewController()
        vc.viewModel = ConsultsViewModelMock(showConsults: true)
        let sut = UINavigationController(rootViewController: vc)
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_ConsultsView_withoutData() {
        let vc = ConsultsViewController()
        vc.viewModel = ConsultsViewModelMock(showConsults: false)
        let sut = UINavigationController(rootViewController: vc)
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_ConsultsTableViewCell() {
        let view = ConsultTableViewCell(frame: CGRect(x: 0, y: 0, width: 400, height: 65))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        guard let date = formatter.date(from: "22/07/2023") else {
            return XCTFail()
        }
        
        let data = ConsultsViewModel.CellData(name: "Primeira Consulta", date: date)
        view.setupCell(with: data)
        assertSnapshot(matching: view, as: .image)
    }
}

private extension ConsultsScreen_SnapShotTests {
    
    class ConsultsViewModelMock: ConsultsViewModelProtocol {
        
        weak var coordinatorDelegate: calcMEI.ConsultsViewModelCoordinatorDelegate?
        weak var viewDelegate: calcMEI.ConsultsViewModelViewDelegate?
        
        private var showConsults: Bool
        var cellDataList = [ConsultsViewModel.CellData]()
        
        init(showConsults: Bool) {
            self.showConsults = showConsults
            generateMockData()
        }
        
        func generateMockData() {
            cellDataList = [
                ConsultsViewModel.CellData(name: "Primeira Consulta", date: makeDate()),
                ConsultsViewModel.CellData(name: "Segunda Consulta", date: makeDate("12/11/2022")),
                ConsultsViewModel.CellData(name: "Ihh Leão vai pegar", date: makeDate("28/04/2023")),
                ConsultsViewModel.CellData(name: "Ferrou", date: makeDate("10/05/2023")),
                ConsultsViewModel.CellData(name: "Suave", date: makeDate("11/02/2024"))
            ]
        }
        
        var consults: [Consult] = []
        var title: String = "Consultas Salvas"
        
        func loadConsults() {
            if showConsults {
                viewDelegate?.consultsViewModel(self, didUpdateConsults: consults)
            } else {
                viewDelegate?.consultsViewModelHasNoConsults(self)
            }
        }
        
        func getNumberOfRowsInSection() -> Int {
            cellDataList.count
        }
        
        func getDataToCell(indexPath: IndexPath) -> calcMEI.ConsultsViewModel.CellData? {
            cellDataList[indexPath.row]
        }
        
        func remove(at index: IndexPath) {
            // don't need
        }
        
        func newConsultSelected() {
            // don't need
        }
        
        func detailSelected(consult: Consult) {
            // don't need
        }
        
        func makeDate(_ dateString: String = "15/06/1995") -> Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            guard let date = formatter.date(from: dateString) else {
                return Date()
            }
            return date
        }
        
    }
}
