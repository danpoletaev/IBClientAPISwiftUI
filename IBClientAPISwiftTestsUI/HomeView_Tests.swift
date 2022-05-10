//
//  HomeView_Tests.swift
//  IBClientAPISwiftTestsUI
//
//  Created by Danil Poletaev on 15.04.2022.
//

import XCTest

class HomeView_Tests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_HomeView_topPortfolioPosition_clickShouldSwitchToPortfolioTab() {
        let app = XCUIApplication()
        app.launchEnvironment = [
            "-UITest_unauthorized": "false",
            "-UITest_mockService": "true",
        ]
        app.launch()
        
        let instanceTextFields = app.textFields["Ex: https://localhost:5000"]
        instanceTextFields.tap()
        instanceTextFields.typeText("http://localhost:5000")
        
        app.buttons["Submit"].tap()
            
        sleep(2)
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["arrow.up.forward.app"].tap()
        sleep(2)
        
        
        let foundDailyPL = elementsQuery.staticTexts["Daily P&L"].waitForExistence(timeout: 2)
        
        XCTAssertTrue(foundDailyPL)
    }

}
