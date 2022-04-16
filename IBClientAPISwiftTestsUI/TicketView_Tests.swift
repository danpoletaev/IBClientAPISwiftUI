//
//  TicketView_Tests.swift
//  IBClientAPISwiftTestsUI
//
//  Created by Danil Poletaev on 16.04.2022.
//

import XCTest

class TicketView_Tests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_TicketView_placeOrder_shouldBuyTicketNSwitchToOrdersTab() {
        let app = XCUIApplication()
        app.launchEnvironment = [
            "-UITest_unauthorized": "false",
            "-UITest_mockService": "true",
        ]
        app.launch()
        
        sleep(2)
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery2 = scrollViewsQuery.otherElements
        let elementsQuery = elementsQuery2.scrollViews.otherElements
        elementsQuery.buttons["BOXL, NASDAQ, 0.3200, -0.0020, 24.6, -4.05"].tap()
        sleep(1)
        
        let tickerElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Ticker").element
        tickerElement.swipeUp()
        elementsQuery2.buttons["Buy"].tap()
        sleep(1)
        
        let quantityTextField = scrollViewsQuery.textFields["quanityTF"]
        quantityTextField.tap()
        quantityTextField.typeText("1")
        
        let limitPrice = scrollViewsQuery.textFields["limitPrice"]
        limitPrice.tap()
        limitPrice.typeText("1")
        
        tickerElement.swipeUp()
        
        elementsQuery2.buttons["Submit"].tap()
        sleep(1)
        elementsQuery2.buttons["Confirm"].tap()
        sleep(1)
        elementsQuery.staticTexts["BIOL"].tap()
        
        let switchedToOrders = elementsQuery2.scrollViews.otherElements.staticTexts["BIOL"].waitForExistence(timeout: 2)
        
        XCTAssertTrue(switchedToOrders)
    }
    
    func test_TicketView_placeOrder_shouldNotBeClickableIfEmptyQuantity() {
        let app = XCUIApplication()
        app.launchEnvironment = [
            "-UITest_unauthorized": "false",
            "-UITest_mockService": "true",
        ]
        app.launch()
        
        sleep(2)
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery2 = scrollViewsQuery.otherElements
        let elementsQuery = elementsQuery2.scrollViews.otherElements
        elementsQuery.buttons["BOXL, NASDAQ, 0.3200, -0.0020, 24.6, -4.05"].tap()
        sleep(1)
        
        let tickerElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Ticker").element
        tickerElement.swipeUp()
        elementsQuery2.buttons["Buy"].tap()
        sleep(1)
        
        let tickerElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Ticker")
        tickerElementsQuery.children(matching: .textField).matching(identifier: "5").element(boundBy: 0).tap()
        
        tickerElement.swipeUp()
        
        elementsQuery2.buttons["Submit"].tap()
        sleep(1)
        let confirmExists = elementsQuery2.buttons["Confirm"].waitForExistence(timeout: 2)
        XCTAssertFalse(confirmExists)
    }

}
