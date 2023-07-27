//
//  ExpensesScreen_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 24/07/23.
//

import XCTest
import SnapshotTesting
@testable import calcMEI

final class ExpensesScreen_SnapShotTests: XCTestCase {
    
    override class func setUp() {
        isRecording = false
    }

    func test_ExpensesViewController() {
        let vc = ExpensesViewController()
        vc.title = "Title"
        vc.view.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        
        assertSnapshot(matching: vc, as: .image(drawHierarchyInKeyWindow: true, precision: 0.99))
    }
    
}
