//
//  ItemDetailViewModel_Tests.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 17/07/23.
//

import XCTest
@testable import calcMEI

final class ItemDetailViewModel_Tests: XCTestCase {
    
    private let itemDetailViewControllerSpy = ItemDetailViewControllerSpy()
    
    func test_ItemDetailViewModel_title_shouldNotBeEmpty() {
        let sut = makeSUT()
        
        let title = sut.title
        
        XCTAssertFalse(title.isEmpty)
        XCTAssertGreaterThan(title.count, 0)
    }
    
    func test_ItemDetailViewModel_UpdateViewWithData_shouldCallUpdateViewWithData() {
        let sut = makeSUT()
        
        sut.updateViewWithData()
        
        XCTAssertEqual(itemDetailViewControllerSpy.calledMethods, [.updateViewWithData])
    }
    
    private func makeSUT() -> ItemDetailViewModel {
        let itemDetail = ResultItem(title: "Teste", result: "testeResult")
        let viewModel = ItemDetailViewModel(itemDetail: itemDetail)
        viewModel.viewDelegate = itemDetailViewControllerSpy
        return viewModel
    }
}

private extension ItemDetailViewModel_Tests {
    
    class ItemDetailViewControllerSpy: ItemDetailViewModelViewDelegate {
        
        enum Methods {
            case updateViewWithData
        }
        
        var calledMethods = [Methods]()
        
        func itemDetailViewModel(_ itemDetailViewModel: calcMEI.ItemDetailViewModel, updateViewWithData: calcMEI.ResultItem) {
            calledMethods.append(.updateViewWithData)
        }
        
    }
    
}
