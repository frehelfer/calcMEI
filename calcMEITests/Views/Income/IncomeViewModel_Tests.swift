//
//  IncomeViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 17/03/23.
//

import XCTest
@testable import calcMEI

final class IncomeViewModel_Tests: XCTestCase {
    
    func test_IncomeViewModel_title_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let title = sut.title
        
        XCTAssertFalse(title.isEmpty)
        XCTAssertGreaterThan(title.count, 0)
    }
    
    private func makeSUT() -> IncomeViewModel {
        IncomeViewModel()
    }

}
