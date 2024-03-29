//
//  ConsultsViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 28/03/23.
//

import XCTest
import CalcMEI_Core
import CoreData
@testable import calcMEI

final class ConsultsViewModel_Tests: XCTestCase {
    
    private let consultServiceSpy = ConsultServiceSpy()
    private let coordinatorSpy = HomeCoordinatorSpy()
    private let viewControllerSpy = ConsultsViewControllerSpy()
    private let analyticsServiceSpy = AnalyticsServiceSpy()

    func test_ConsultsViewModel_title_shouldNotBeEmpty() {
        XCTAssertFalse(makeSUT().title.isEmpty)
    }
    
    func test_ConsultsViewModel_getNumberOfRowsInSection_shouldBeZero() {
        let sut = makeSUT()
        
        let number = sut.getNumberOfRowsInSection()
        
        XCTAssertEqual(number, 0)
    }
    
    func test_ConsultsViewModel_newConsultSelected_shouldCallNewConsultSelected() {
        let sut = makeSUT()
        
        sut.newConsultSelected()
        
        XCTAssertEqual(coordinatorSpy.calledMethods, [.consultsViewModelDidSelectNewConsult])
    }
    
    func test_ConsultsViewModel_newConsultSelected_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.newConsultSelected()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
        XCTAssertEqual(analyticsServiceSpy.eventName, "ConsultsView_NewConsultSelected")
        XCTAssertNil(analyticsServiceSpy.eventParams)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> ConsultsViewModel {
        let viewModel = ConsultsViewModel(
            consultService: consultServiceSpy,
            analyticsService: analyticsServiceSpy
        )
        viewModel.coordinatorDelegate = coordinatorSpy
        viewModel.viewDelegate = viewControllerSpy
        return viewModel
    }

}

private extension ConsultsViewModel_Tests {
    
    class ConsultsViewControllerSpy: ConsultsViewModelViewDelegate {
        
        enum Methods {
            case willChangeConsults
            case updateConsults
            case didChangeConsults
            case showDeleteAlert
        }
        
        var calledMethods = [Methods]()
        
        func consultsViewModelWillChangeConsults() {
            calledMethods.append(.willChangeConsults)
        }
        
        func consultsViewModelUpdateConsults(_ controller: NSFetchedResultsController<NSFetchRequestResult>, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            calledMethods.append(.updateConsults)
        }
        
        func consultsViewModelDidChangeConsults() {
            calledMethods.append(.didChangeConsults)
        }
        
        func consultsViewModelShowDeleteAlert(title: String, message: String, confirmDeletePressed: @escaping () -> Void) {
            calledMethods.append(.showDeleteAlert)
        }
        
    }
    
    class HomeCoordinatorSpy: ConsultsViewModelCoordinatorDelegate {
        enum Methods {
            case consultsViewModelDidSelectNewConsult
            case consultsViewModelDidSelectDetail
        }
        
        var calledMethods = [Methods]()
        
        func consultsViewModelDidSelectNewConsult(_ consultsViewModel: ConsultsViewModelProtocol) {
            calledMethods.append(.consultsViewModelDidSelectNewConsult)
        }
        
        func consultsViewModelDidSelectDetail(_ consultsViewModel: ConsultsViewModelProtocol, consult: Consult) {
            calledMethods.append(.consultsViewModelDidSelectDetail)
        }
        
    }
}
