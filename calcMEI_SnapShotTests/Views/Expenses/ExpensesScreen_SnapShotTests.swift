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

    func test_ExpensesViewController() {
        let vc = ExpensesViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.title = "Title"
        _ = vc.view
        
        assertSnapshot(matching: nav, as: .image(drawHierarchyInKeyWindow: true, precision: 0.99))
    }
    
}
