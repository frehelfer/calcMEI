//
//  IncomeScreen_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 24/07/23.
//

import XCTest
import SnapshotTesting
@testable import calcMEI

final class IncomeScreen_SnapShotTests: XCTestCase {

    func test_IncomeViewController() {
        let vc = IncomeViewController()
        assertSnapshot(matching: vc, as: .image)
    }
    
}
