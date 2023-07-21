//
//  ConsultsViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 28/03/23.
//

import XCTest
import CalcMEI_Core
@testable import calcMEI

final class ConsultsViewModel_Tests: XCTestCase {
    
    private let consultServiceSpy = ConsultServiceSpy()
    private let coordinatorSpy = HomeCoordinatorSpy()
    private let viewControllerSpy = ConsultsViewControllerSpy()
    private let analyticsServiceSpy = AnalyticsServiceSpy()

    func test_ConsultsViewModel_title_shouldNotBeEmpty() {
        XCTAssertFalse(makeSUT().title.isEmpty)
    }
    
    func test_ConsultsViewModel_loadConsults_shouldGetConsultsFromService() {
        let sut = makeSUT()
        
        sut.loadConsults()
        
        XCTAssertEqual(consultServiceSpy.calledMethods, [.fetchConsults])
    }
    
    func test_ConsultsViewModel_loadConsults_shouldNotCallDidUpdateConsults() {
        let sut = makeSUT()
        
        sut.loadConsults()
        
        XCTAssertEqual(viewControllerSpy.calledMethods, [.hasNoConsults])
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
            case didUpdateConsults
            case hasNoConsults
        }
        
        var calledMethods = [Methods]()
        
        func consultsViewModelHasNoConsults(_ consultsViewModel: calcMEI.ConsultsViewModel) {
            calledMethods.append(.hasNoConsults)
        }
        
        func consultsViewModel(_ consultsViewModel: ConsultsViewModel, didUpdateConsults: [Consult]) {
            calledMethods.append(.didUpdateConsults)
        }
        
    }
    
    class HomeCoordinatorSpy: ConsultsViewModelCoordinatorDelegate {
        enum Methods {
            case consultsViewModelDidSelectNewConsult
            case consultsViewModelDidSelectDetail
        }
        
        var calledMethods = [Methods]()
        
        func consultsViewModelDidSelectNewConsult(_ consultsViewModel: ConsultsViewModel) {
            calledMethods.append(.consultsViewModelDidSelectNewConsult)
        }
        
        func consultsViewModelDidSelectDetail(_ consultsViewModel: ConsultsViewModel, consult: Consult) {
            calledMethods.append(.consultsViewModelDidSelectDetail)
        }
        
    }
}
