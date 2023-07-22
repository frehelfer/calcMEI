//
//  calcMEI_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 21/07/23.
//

import SnapshotTesting
import XCTest
import CalcMEI_Core
@testable import calcMEI

class MyViewControllerTests: XCTestCase {
    
    func test_HomeViewController() {
        let vc = HomeViewController()
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_IncomeViewController() {
        let vc = IncomeViewController()
        assertSnapshot(matching: vc, as: .image, record: false)
    }
    
    func test_ExpensesViewController() {
        let vc = ExpensesViewController()
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_ItemDetailViewController() {
        let vc = ItemDetailViewController()
        assertSnapshot(matching: vc, as: .image)
    }
    
}
