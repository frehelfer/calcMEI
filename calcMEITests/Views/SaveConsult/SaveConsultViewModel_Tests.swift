//
//  SaveConsultViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 24/03/23.
//

import XCTest
@testable import calcMEI

final class SaveConsultViewModel_Tests: XCTestCase {
    
    private let viewControllerSpy = SaveConsultViewControllerSpy()
    private let coordinatorSpy = HomeCoordinatorSpy()
    private let consultServiceSpy = LocalConsultServiceSpy()
    
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
    
    private func makeSUT() -> SaveConsultViewModel {
        let consultService = consultServiceSpy
        let count = Count.makeCount()
        let viewModel = SaveConsultViewModel(consultService: consultService, count: count)
        viewModel.viewDelegate = viewControllerSpy
        viewModel.coordinatorDelegate = coordinatorSpy
        return viewModel
    }

}

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

class LocalConsultServiceSpy: ConsultService {
    enum Methods {
        case createConsult
        case deleteConsult
        case fetchConsults
    }
    
    var calledMethods = [Methods]()
    
    func createConsult(count: calcMEI.Count) {
        calledMethods.append(.createConsult)
    }
    
    func deleteConsult(consult: calcMEI.Consult) {
        calledMethods.append(.deleteConsult)
    }
    
    func fetchConsults() -> [calcMEI.Consult]? {
        calledMethods.append(.fetchConsults)
        return nil
    }
    
}
