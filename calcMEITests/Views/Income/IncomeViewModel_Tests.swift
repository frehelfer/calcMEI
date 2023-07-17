//
//  IncomeViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 17/03/23.
//

import XCTest
import CalcMEI_Core
@testable import calcMEI

final class IncomeViewModel_Tests: XCTestCase {
    
    private let coordinatorSpy = IncomeCoordinatorSpy()
    private let analyticsServiceSpy = AnalyticsServiceSpy()

    func test_IncomeViewModel_title_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let title = sut.title
        
        XCTAssertFalse(title.isEmpty)
        XCTAssertGreaterThan(title.count, 0)
    }
    
    func test_IncomeViewModel_nextBottomButtonSelected_shouldLogEvent() {
        let sut = makeSUT()
        let data = makeData()
        
        sut.nextBottomButtonSelected(incomeData: data)
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
    }
    
    func test_IncomeViewModel_nextBottomButtonSelected_shouldCallIncomeViewModelDidSelectNext() {
        let sut = makeSUT()
        let data = makeData()
        
        sut.nextBottomButtonSelected(incomeData: data)
        
        XCTAssertEqual(coordinatorSpy.calledMethods, [.incomeViewModelDidSelectNext])
    }
    
    func test_IncomeViewModel_nextNavButtonSelected_shouldLogEvent() {
        let sut = makeSUT()
        let data = makeData()
        
        sut.nextNavButtonSelected(incomeData: data)
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
    }
    
    func test_IncomeViewModel_nextNavButtonSelected_shouldCallIncomeViewModelDidSelectNext() {
        let sut = makeSUT()
        let data = makeData()
        
        sut.nextNavButtonSelected(incomeData: data)
        
        XCTAssertEqual(coordinatorSpy.calledMethods, [.incomeViewModelDidSelectNext])
    }
    
    func test_IncomeViewModel_backButtonSelected_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.backButtonSelected()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
    }

    private func makeSUT() -> IncomeViewModel {
        let viewModel = IncomeViewModel(analyticsService: analyticsServiceSpy)
        viewModel.coordinatorDelegate = coordinatorSpy
        return viewModel
    }
    
    private func makeData() -> IncomeViewModel.IncomeData {
        IncomeViewModel.IncomeData(
            inServiceProvision: Double.random(in: 0...100_000_000),
            inCommerce: Double.random(in: 0...100_000_000),
            inPassengerTransport: Double.random(in: 0...100_000_000)
        )
    }

}

private extension IncomeViewModel_Tests {
    
    class IncomeCoordinatorSpy: IncomeViewModelCoordinatorDelegate {
        
        enum Methods {
            case incomeViewModelDidSelectNext
        }
        
        var calledMethods = [Methods]()
        
        func incomeViewModelDidSelectNext(_ incomeViewModel: calcMEI.IncomeViewModel, count: Count) {
            calledMethods.append(.incomeViewModelDidSelectNext)
        }
        
    }
    
}
