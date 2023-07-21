//
//  HomeView_UITests.swift
//  calcMEI_UITests
//
//  Created by Frédéric Helfer on 21/07/23.
//

import XCTest

final class HomeView_UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_HomeView_shouldNavigateThroughConsultCycleWithoutDataInput() {
        
        app.buttons["newConsultButton"].tap()
        app.buttons["goToExpensesButton"].tap()
        app.buttons["goToResultButton"].tap()
        app.buttons["popToHomeButton"].tap()
        let navBar = app.navigationBars["calcMEI"]
        
        XCTAssertTrue(navBar.exists)
    }
    
    func test_HomeView_shouldNavigateThroughConsultCycleWithDataInput() {
        
        app.buttons["newConsultButton"].tap()
        
        let servicesFormContainer = app.otherElements["servicesFormContainer"]
        servicesFormContainer.textFields.element(boundBy: 0).tap()
        
        servicesFormContainer.typeText("10000")

        let returnButton = app.toolbars["Toolbar"].buttons["Retorno"]
        returnButton.tap()
        
        let commerceFormContainer  = app.otherElements["commerceFormContainer"]
        commerceFormContainer.textFields.element.tap()
        commerceFormContainer.typeText("10000")
        returnButton.tap()
        
        let transportFormContainer  = app.otherElements["transportFormContainer"]
        transportFormContainer.textFields.element.tap()
        transportFormContainer.typeText("10000")
        returnButton.tap()
        
        app.buttons["goToExpensesButton"].tap()
        
        let expensesFormContainer  = app.otherElements["expensesFormContainer"]
        expensesFormContainer.textFields.element.tap()
        expensesFormContainer.typeText("10000")
        returnButton.tap()

        app.buttons["goToResultButton"].tap()
        
        let tablesQuery = app.tables
        let result1 = tablesQuery.cells.staticTexts["R$ 300,00"]
        let result2 = tablesQuery.cells.staticTexts["R$ 200,00"]

        XCTAssertTrue(result1.exists)
        XCTAssertTrue(result2.exists)
 
    }
    
    
}
