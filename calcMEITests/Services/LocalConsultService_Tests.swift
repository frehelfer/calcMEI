//
//  LocalConsultService_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 23/03/23.
//

import XCTest
@testable import calcMEI

final class LocalConsultService_Tests: XCTestCase {
    
    func test_LocalConsultService_fetchConsult_shouldBeEmpty() {
        // given
        let sut = makeSUT()
        
        // when
        let result = sut.fetchConsults()
        
        // then
        XCTAssertTrue(result!.isEmpty)
    }

    func test_LocalConsultService_createConsult_shouldCreateConsult() {
        // given
        let sut = makeSUT()
        let count = Count.makeCount()
        
        // when
        sut.createConsult(count: count)
        let consult = sut.fetchConsults()
        
        // then
        XCTAssertEqual(consult?.count, 1)
        XCTAssertEqual(consult?.first?.id, count.id)
    }
    
    func test_LocalConsultService_createConsult_shouldCreateMultipleConsult_stress() {
        // given
        let sut = makeSUT()
        var sum = 0
        
        for _ in 0..<100 {
            let count = Count.makeCount()
            sut.createConsult(count: count)
            sum += 1
        }
        
        // when
        let consult = sut.fetchConsults()
        
        // then
        XCTAssertEqual(consult?.count, sum)
    }
    
    func test_LocalConsultService_deleteConsult_shouldDeleteConsult() {
        // given
        let sut = makeSUT()
        
        sut.createConsult(count: Count.makeCount())
        sut.createConsult(count: Count.makeCount())
    
        // when
        let consults = sut.fetchConsults()
        let consultA = consults!.first!
        let consultB = consults!.last!
        sut.deleteConsult(consult: consultA)
        
        let result = sut.fetchConsults()
        
        // then
        XCTAssertEqual(result?.count, 1)
        XCTAssertTrue(result!.contains(consultB))
    }
    
    private func makeSUT(coreDataManager: CoreDataManaging = CoreDataTestManager()) -> LocalConsultService {
        LocalConsultService(coreDataManager: coreDataManager)
    }

}
