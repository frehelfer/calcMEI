//
//  ExpensesViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 17/03/23.
//

import XCTest
import CalcMEI_Core
@testable import calcMEI

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviorv
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]

final class ExpensesViewModel_Tests: XCTestCase {
    
    private let expensesCoordinatorSpy = ExpensesCoordinatorSpy()
    private let analyticsServiceSpy = AnalyticsServiceSpy()
    
    func test_ExpensesViewModel_count_shouldBeInjectedValue() {
        let count = Count()

        let sut = makeSUT(count: count)

        XCTAssertEqual(sut.count.id, count.id)
    }
    
    func test_ExpensesViewModel_title_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let title = sut.title
        
        XCTAssertFalse(title.isEmpty)
        XCTAssertGreaterThan(title.count, 0)
    }
    
    func test_ExpensesViewModel_updateCount_shouldUpdateExpensesCount() {
        let sut = makeSUT()
        let value: Double = Double.random(in: 1..<200_000)
        
        sut.updateCount(expenses: value)
        
        XCTAssertEqual(sut.count.outExpenses, value)
    }
    
    func test_ExpensesViewModel_nextBottomButtonSelected_shouldCallNextPage() {
        let sut = makeSUT()
        
        sut.nextBottomButtonSelected()
        
        XCTAssertEqual(expensesCoordinatorSpy.calledMethods, [.expensesViewModelDidSelectNext])
    }
    
    func test_ExpensesViewModel_nextBottomButtonSelected_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.nextBottomButtonSelected()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
        XCTAssertEqual(analyticsServiceSpy.eventName, "ExpensesView_ResultBottomButtonSelected")
        XCTAssertNil(analyticsServiceSpy.eventParams)
    }
    
    func test_ExpensesViewModel_nextNavButtonSelected_shouldCallNextPage() {
        let sut = makeSUT()
        
        sut.nextNavButtonSelected()
        
        XCTAssertEqual(expensesCoordinatorSpy.calledMethods, [.expensesViewModelDidSelectNext])
    }
    
    func test_ExpensesViewModel_nextNavButtonSelected_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.nextNavButtonSelected()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
        XCTAssertEqual(analyticsServiceSpy.eventName, "ExpensesView_ResultNavButtonSelected")
        XCTAssertNil(analyticsServiceSpy.eventParams)
    }
    
    func test_ExpensesViewModel_backButtonSelected_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.backButtonSelected()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
        XCTAssertEqual(analyticsServiceSpy.eventName, "ExpensesView_BackButtonSelected")
        XCTAssertNil(analyticsServiceSpy.eventParams)
    }
    
    private func makeSUT(count: Count = Count()) -> ExpensesViewModel {
        let viewModel = ExpensesViewModel(
            count: count,
            analyticsService: analyticsServiceSpy
        )
        viewModel.coordinatorDelegate = expensesCoordinatorSpy
        return viewModel
    }

}

private extension ExpensesViewModel_Tests {
    
    class ExpensesCoordinatorSpy: ExpensesViewModelCoordinatorDelegate {
        
        enum Methods {
            case expensesViewModelDidSelectNext
        }
        
        var calledMethods = [Methods]()
        
        func expensesViewModelDidSelectNext(_ expensesViewModel: calcMEI.ExpensesViewModel, count: Count) {
            calledMethods.append(.expensesViewModelDidSelectNext)
        }
        
    }
    
}
