//
//  SaveConsultViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 24/03/23.
//

import XCTest
import CalcMEI_Core
@testable import calcMEI

final class SaveConsultViewModel_Tests: XCTestCase {
    
    private let viewControllerSpy = SaveConsultViewControllerSpy()
    private let coordinatorSpy = HomeCoordinatorSpy()
    private let consultServiceSpy = ConsultServiceSpy()
    
    func test_saveConsultViewModel_title_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let title = sut.title
        
        XCTAssertFalse(title.isEmpty)
        XCTAssertGreaterThan(title.count, 0)
    }
    
    func test_saveConsultViewModel_updateViewWithCount_shouldCallSaveConsultViewModel() {
        let sut = makeSUT()
        
        sut.updateViewWithCount()
        
        XCTAssertEqual(viewControllerSpy.calledMethods, [.saveConsultViewModel])
    }
    
    func test_saveConsultViewModel_updateCount_shouldUpdateCountWithName() {
        let sut = makeSUT()
        let countName: String = UUID().uuidString
        
        sut.updateCount(countName: countName)
        
        XCTAssertEqual(sut.count.name, countName)
    }
    
    func test_saveConsultViewModel_saveConsult_shouldCallCreateConsult() {
        let sut = makeSUT()
        
        sut.saveConsult()
        
        XCTAssertEqual(consultServiceSpy.calledMethods, [.createConsult])
    }
    
    func test_saveConsultViewModel_saveSelected_shouldCallSaveConsultViewModelDidSelectSave() {
        let sut = makeSUT()
        
        sut.saveSelected()
        
        XCTAssertEqual(coordinatorSpy.calledMethods, [.saveConsultViewModelDidSelectSave])
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> SaveConsultViewModel {
        let consultService = consultServiceSpy
        let count = Count.makeCount()
        let viewModel = SaveConsultViewModel(consultService: consultService, count: count)
        viewModel.viewDelegate = viewControllerSpy
        viewModel.coordinatorDelegate = coordinatorSpy
        return viewModel
    }

}

private extension SaveConsultViewModel_Tests {
    
    class SaveConsultViewControllerSpy: SaveConsultViewModelViewDelegate {
        enum Methods {
            case saveConsultViewModel
        }
        
        var calledMethods = [Methods]()
        
        func saveConsultViewModel(_ saveConsultViewModel: calcMEI.SaveConsultViewModel, updateViewWithCount: calcMEI.Count) {
            calledMethods.append(.saveConsultViewModel)
        }
        
    }
    
    class HomeCoordinatorSpy: SaveConsultViewModelCoordinatorDelegate {
        enum Methods {
            case saveConsultViewModelDidSelectSave
        }
        
        var calledMethods = [Methods]()
        
        func saveConsultViewModelDidSelectSave(_ saveConsultViewModel: calcMEI.SaveConsultViewModel) {
            calledMethods.append(.saveConsultViewModelDidSelectSave)
        }
        
    }
}
