//
//  SaveConsultViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 24/03/23.
//

import XCTest
@testable import calcMEI

final class SaveConsultViewModel_Tests: XCTestCase {
    
    func test_saveConsultViewModel_init_shouldInitWithCount() {
        let consultService = LocalConsultService(coreDataManager: CoreDataTestManager())
        let count: Count = Count.makeCount()
        
        let sut = SaveConsultViewModel(consultService: consultService, count: count)
        
        XCTAssertEqual(sut.count.id, count.id)
    }

}
