//
//  ResultViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 17/03/23.
//

import XCTest
@testable import calcMEI

final class ResultViewModel_Tests: XCTestCase {

    func test_ResultViewModel_count_shouldBeInjectedValue() {
        // given
        let count = Count()
        
        // when
        let sut = makeSUT(count: count)
        
        // then
        XCTAssertEqual(sut.count.id, count.id)
    }
    
    func test_ResultViewModel_title_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let title = sut.title
        
        XCTAssertFalse(title.isEmpty)
        XCTAssertGreaterThan(title.count, 0)
    }
    
    private func makeSUT(count: Count = Count()) -> ExpensesViewModel {
        ExpensesViewModel(count: count)
    }

}
