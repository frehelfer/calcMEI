//
//  ExpensesViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 17/03/23.
//

import XCTest
@testable import calcMEI

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviorv
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]

final class ExpensesViewModel_Tests: XCTestCase {
    
    func test_ExpensesViewModel_count_shouldBeInjectedValue() {
        // given
        let count = Count()
        
        // when
        let sut = makeSUT(count: count)
        
        // then
        XCTAssertEqual(sut.count.id, count.id)
    }
    
    func test_ExpensesViewModel_title_shouldNotBeEmpty() {
        // given
        let sut = makeSUT()
        
        // when
        let title = sut.title
        
        // then
        XCTAssertFalse(title.isEmpty)
        XCTAssertGreaterThan(title.count, 0)
    }
    
    func test_ExpensesViewModel_updateCount_shouldUpdateExpensesCount() {
        // given
        let sut = makeSUT()
        let value: Double = Double.random(in: 1..<200_000)
        
        // when
        sut.updateCount(expenses: value)
        
        // then
        XCTAssertEqual(sut.count.outExpenses, value)
    }
    
    private func makeSUT(count: Count = Count()) -> ExpensesViewModel {
        ExpensesViewModel(count: count)
    }

}
