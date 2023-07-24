//
//  HomeScreen_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 24/07/23.
//

import XCTest
import SnapshotTesting
@testable import calcMEI

final class HomeScreen_SnapShotTests: XCTestCase {

    func test_HomeViewController() {
        let vc = HomeViewController()
        assertSnapshot(matching: vc, as: .image)
    }
    
}
