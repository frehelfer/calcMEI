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

    override func setUp() {
        isRecording = false
    }
    
    func test_IncomeViewController() {
        let vc = IncomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.title = "Title"
        _ = vc.view
        
        assertSnapshot(matching: nav, as: .image(drawHierarchyInKeyWindow: true, precision: 0.99))
    }
    
}
