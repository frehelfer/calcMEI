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
        let nav = UINavigationController(rootViewController: vc)
        vc.title = "Título"
        assertSnapshot(matching: nav, as: .image(precision: 0.99))
    }
    
}
