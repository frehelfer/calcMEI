//
//  CustomFormContainer_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 27/07/23.
//

import XCTest
import SnapshotTesting
@testable import calcMEI

class CustomFormContainer_SnapShotTests: XCTestCase {
    
    override class func setUp() {
        isRecording = false
    }
    
    func test_CustomFormContainer_smallTitle_withoutDescription_green() {
        let view = CustomFormContainer(title: "Testing small title", description: nil, colorType: .green)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
        
        assertSnapshot(matching: view, as: .image(drawHierarchyInKeyWindow: true, precision: 0.99))
    }
    
    func test_CustomFormContainer_smallTitle_withoutDescription_red() {
        let view = CustomFormContainer(title: "Testing small title", description: nil, colorType: .red)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
        
        assertSnapshot(matching: view, as: .image(drawHierarchyInKeyWindow: true, precision: 0.99))
    }
    
    func test_CustomFormContainer_smallTitle_withClosedDescription_green() {
        let view = CustomFormContainer(title: "Testing small title", description: "Some description.", colorType: .green)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
        
        assertSnapshot(matching: view, as: .image(drawHierarchyInKeyWindow: true, precision: 0.99))
    }
    
    func test_CustomFormContainer_smallTitle_withClosedDescription_red() {
        let view = CustomFormContainer(title: "Testing small title", description: "Some description.", colorType: .red)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
        
        assertSnapshot(matching: view, as: .image(drawHierarchyInKeyWindow: true, precision: 0.99))
    }
    
    func test_CustomFormContainer_largeTitle_withoutDescription_green() {
        let view = CustomFormContainer(title: "Testing a very large title with a lot of words!!! AAAAA!! I don't know what to write here.", description: nil, colorType: .green)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
        
        assertSnapshot(matching: view, as: .image(drawHierarchyInKeyWindow: true, precision: 0.99))
    }
    
    func test_CustomFormContainer_largeTitle_withoutDescription_red() {
        let view = CustomFormContainer(title: "Testing a very large title with a lot of words!!! AAAAA!! I don't know what to write here.", description: nil, colorType: .red)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
        
        assertSnapshot(matching: view, as: .image(drawHierarchyInKeyWindow: true, precision: 0.99))
    }

}
