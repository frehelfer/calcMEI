//
//  ResultViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 17/03/23.
//

import XCTest
import CalcMEI_Core
@testable import calcMEI

final class ResultViewModel_Tests: XCTestCase {
    
    private let resultCoordinatorSpy = ResultCoordinatorSpy()
    private let resultViewControllerSpy = ResultViewControllerSpy()
    private let analyticsServiceSpy = AnalyticsServiceSpy()
    private let consultServiceSpy = ConsultServiceSpy()
    
    func test_ResultViewModel_title_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let title = sut.title
        
        XCTAssertFalse(title.isEmpty)
        XCTAssertGreaterThan(title.count, 0)
    }
    
    func test_ResultViewModel_updateViewWithCount_shouldCallUpdateViewWithCount() {
        let sut = makeSUT()
        
        sut.updateViewWithCount()
        
        XCTAssertEqual(resultViewControllerSpy.calledMethods, [.updateViewWithCount])
    }
    
    func test_ResultViewModel_resetSelected_shouldCallDidSelectReset() {
        let sut = makeSUT()
        
        sut.resetSelected()
        
        XCTAssertEqual(resultCoordinatorSpy.calledMethods, [.resultViewModelDidSelectReset])
    }
    
    func test_ResultViewModel_resetSelected_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.resetSelected()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
        XCTAssertEqual(analyticsServiceSpy.eventName, "ResultView_RestartSelected")
        XCTAssertNil(analyticsServiceSpy.eventParams)
    }
    
    func test_ResultViewModel_saveConsultSelected_shouldCallCreateConsult() {
        let sut = makeSUT()
        let text = UUID().uuidString
        
        sut.saveConsultSelected(text)
        
        XCTAssertEqual(consultServiceSpy.calledMethods, [.createConsult])
        XCTAssertEqual(resultCoordinatorSpy.calledMethods, [.resultViewModelDidSelectReset])
    }
    
    func test_ResultViewModel_saveConsultSelected_shouldLogEvent() {
        let sut = makeSUT()
        let text = UUID().uuidString
        
        sut.saveConsultSelected(text)
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
        XCTAssertEqual(analyticsServiceSpy.eventName, "ResultView_SaveConsultSelected")
        XCTAssertNil(analyticsServiceSpy.eventParams)
    }
    
    func test_ResultViewModel_backButtonPressed_shouldLogEvent() {
        let sut = makeSUT()
        
        sut.backButtonPressed()
        
        XCTAssertTrue(analyticsServiceSpy.calledLogEvent)
        XCTAssertEqual(analyticsServiceSpy.eventName, "ResultView_BackButtonSelected")
        XCTAssertNil(analyticsServiceSpy.eventParams)
    }
    
    private func makeSUT(count: Count = Count()) -> ResultViewModel {
        let viewModel = ResultViewModel(
            count: count,
            consultService: consultServiceSpy,
            analyticsService: analyticsServiceSpy
        )
        viewModel.coordinatorDelegate = resultCoordinatorSpy
        viewModel.viewDelegate = resultViewControllerSpy
        return viewModel
    }

}

private extension ResultViewModel_Tests {
    
    class ResultCoordinatorSpy: ResultViewModelCoordinatorDelegate {
        
        enum Methods {
            case resultViewModelDidSelectReset
            case resultViewModelDidSelectItemDetail
        }
        
        var calledMethods = [Methods]()
        
        func resultViewModelDidSelectReset(_ resultViewModel: calcMEI.ResultViewModelProtocol) {
            calledMethods.append(.resultViewModelDidSelectReset)
        }
        
        func resultViewModelDidSelectItemDetail(_ resultViewModel: calcMEI.ResultViewModelProtocol, resultItem: calcMEI.ResultItem) {
            calledMethods.append(.resultViewModelDidSelectItemDetail)
        }
        
    }
    
    class ResultViewControllerSpy: ResultViewModelViewDelegate {
        
        enum Methods {
            case updateViewWithCount
        }
        
        var calledMethods = [Methods]()
        
        func resultViewModel(_ resultViewMode: calcMEI.ResultViewModelProtocol, updateViewWithCount: [calcMEI.ResultItem]) {
            calledMethods.append(.updateViewWithCount)
        }
        
    }
}


