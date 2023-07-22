//
//  ResultScreen_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 22/07/23.
//

import XCTest
import SnapshotTesting
@testable import calcMEI

class ResultScreen_SnapShotTests {
    
    // testar com cells?
    func test_ResultViewController_withoutData() {
        let vc = ResultViewController()
        assertSnapshot(matching: vc, as: .image)
    }
    
//    func test_ResultViewController_withData() {
//        let vc = ResultViewController()
//        vc.viewModel =
//        assertSnapshot(matching: vc, as: .image)
//    }
    
}
