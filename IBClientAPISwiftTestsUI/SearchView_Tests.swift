//
//  SearchView_Tests.swift
//  IBClientAPISwiftTestsUI
//
//  Created by Danil Poletaev on 14.04.2022.
//

import XCTest

class SearchView_Tests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SearchView_unauthorizedSheet_shouldFindTickets() {
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
        let barNavigationBar = app.navigationBars["Bar"]
        barNavigationBar.buttons["Search"].tap()
        let searchField = barNavigationBar.searchFields["Search"]
        searchField.tap()
        sleep(1)
        searchField.typeText("App")
        
        sleep(2)
        
        let foundTicketExists = app.scrollViews.otherElements.tables.cells["APPLOVIN CORP-CLASS A, NASDAQ"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.waitForExistence(timeout: 3)
        
        XCTAssertTrue(foundTicketExists)
    }

}
