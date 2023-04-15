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
        
        XCTAssertEqual(viewControllerSpy.calledMethods, [])
    }
    
    
    
    
    
    // MARK: - Helpers
    
    private func makeSUT() -> ConsultsViewModel {
        let viewModel = ConsultsViewModel(consultService: consultServiceSpy)
        viewModel.coordinatorDelegate = coordinatorSpy
        viewModel.viewDelegate = viewControllerSpy
        return viewModel
    }

}

private extension ConsultsViewModel_Tests {
    
    class ConsultsViewControllerSpy: ConsultsViewModelViewDelegate {
        enum Methods {
            case didUpdateConsults
        }
        
        var calledMethods = [Methods]()
        
        func consultsViewModel(_ consultsViewModel: ConsultsViewModel, didUpdateConsults: [Consult]) {
            calledMethods.append(.didUpdateConsults)
        }
        
        
    }
    
    class HomeCoordinatorSpy: ConsultsViewModelCoordinatorDelegate {
        enum Methods {
            case saveConsultViewModelDidSelectSave
        }
        
        var calledMethods = [Methods]()
        
        func consultsViewModelDidSelectNewConsult(_ consultsViewModel: ConsultsViewModel) {
            calledMethods.append(.saveConsultViewModelDidSelectSave)
        }
        
    }
}
