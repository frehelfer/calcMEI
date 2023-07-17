//
//  HomeViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 12/07/23.
//

import XCTest
@testable import calcMEI

final class HomeViewModel_Tests: XCTestCase {
    
    private let coordinatorSpy = HomeCoordinatorSpy()
    private let analyticsServiceSpy = AnalyticsServiceSpy()
    
    func test_homeViewModel_title_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let title = sut.title
        
        XCTAssertFalse(title.isEmpty)
        XCTAssertGreaterThan(title.count, 0)
    }
    
    func test_homeViewModel_startSelected_shouldCallHomeViewModelDidSelectStart() {
        let sut = makeSUT()
        
        sut.startSelected()
        
        XCTAssertEqual(coordinatorSpy.calledMethods, [.homeViewModelDidSelectStart])
    }
    
    func test_homeViewModel_startSelected_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.startSelected()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
    }
    
    func test_homeViewModel_settingsSelected_shouldCallHomeViewModelDidSelectSettings() {
        let sut = makeSUT()
        
        sut.settingsSelected()

        XCTAssertEqual(coordinatorSpy.calledMethods, [.homeViewModelDidSelectSettings])
    }
    
    func test_homeViewModel_settingsSelected_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.settingsSelected()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
    }
    
    func test_homeViewModel_settingsSelected_shouldCallHomeViewModelDidSelectConsults() {
        let sut = makeSUT()
        
        sut.consultsSelected()

        XCTAssertEqual(coordinatorSpy.calledMethods, [.homeViewModelDidSelectConsults])
    }
    
    func test_homeViewModel_consultsSelected_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.consultsSelected()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
    }
    
    func test_homeViewModel_openUrl_shouldLogEvent() {
        let sut = makeSUT()
        let url = URL(string: UUID().uuidString)!
        
        sut.openUrl(url: url)
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
    }
    
    private func makeSUT() -> HomeViewModel {
        let viewModel = HomeViewModel(analyticsService: analyticsServiceSpy)
        viewModel.coordinatorDelegate = coordinatorSpy
        return viewModel
    }
    
}

private extension HomeViewModel_Tests {
    
    class HomeCoordinatorSpy: HomeViewModelCoordinatorDelegate {
        
        enum Methods {
            case homeViewModelDidSelectStart
            case homeViewModelDidSelectSettings
            case homeViewModelDidSelectConsults
        }
        
        var calledMethods = [Methods]()
        
        func homeViewModelDidSelectStart(_ homeViewModel: calcMEI.HomeViewModel) {
            calledMethods.append(.homeViewModelDidSelectStart)
        }
        
        func homeViewModelDidSelectSettings(_ homeViewModel: calcMEI.HomeViewModel) {
            calledMethods.append(.homeViewModelDidSelectSettings)
        }
        
        func homeViewModelDidSelectConsults(_ homeViewModel: calcMEI.HomeViewModel) {
            calledMethods.append(.homeViewModelDidSelectConsults)
        }
    }
    
}
