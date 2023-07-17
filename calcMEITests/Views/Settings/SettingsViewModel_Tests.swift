//
//  SettingsViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 21/03/23.
//

import XCTest
@testable import calcMEI

final class SettingsViewModel_Tests: XCTestCase {
    
    private let analyticsServiceSpy = AnalyticsServiceSpy()
    private let viewDelegateSpy = SettingsViewControllerSpy()

    func test_settingsViewModel_appVersion_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let appVersion: String = sut.appVersion
        
        XCTAssertFalse(appVersion.isEmpty)
        XCTAssertGreaterThan(appVersion.count, 0)
    }
    
    func test_settingsViewModel_updateViewWithData_shouldUpdateViewWithData() {
        let sut = makeSUT()
        
        sut.updateViewWithData()
        
        XCTAssertEqual(viewDelegateSpy.calledMethods, [.updateViewWith])
    }
    
    private func makeSUT() -> SettingsViewModel {
        let viewModel = SettingsViewModel(analyticsService: analyticsServiceSpy)
        viewModel.viewDelegate = viewDelegateSpy
        return viewModel
    }

}

private extension SettingsViewModel_Tests {
    
    class SettingsViewControllerSpy: SettingsViewModelViewDelegate {
        
        enum Methods {
            case updateViewWith
        }
        
        var calledMethods = [Methods]()
        
        func settingsViewModel(_ settingsViewModel: calcMEI.SettingsViewModel, updateViewWith: [calcMEI.SettingsViewModel.SettingsSection]) {
            calledMethods.append(.updateViewWith)
        }
        
    }
    
}
