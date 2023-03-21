//
//  SettingsViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 21/03/23.
//

import XCTest
@testable import calcMEI

final class SettingsViewModel_Tests: XCTestCase {

    func test_settingsViewModel_appVersion_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let appVersion: String = sut.appVersion
        
        XCTAssertFalse(appVersion.isEmpty)
        XCTAssertGreaterThan(appVersion.count, 0)
    }
    
    private func makeSUT() -> SettingsViewModel {
        SettingsViewModel()
    }

}
