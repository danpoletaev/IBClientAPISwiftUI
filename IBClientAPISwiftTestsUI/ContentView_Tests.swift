//
//  IBClientAPISwiftTestsUI.swift
//  IBClientAPISwiftTestsUI
//
//  Created by Danil Poletaev on 14.04.2022.
//

import XCTest
import IBClientAPISwiftUI

class ContenView_Tests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ContentView_unauthorizedSheet_shouldShowUnauthorizedSheet_HTTP() {
            let app = XCUIApplication()
            app.launchEnvironment = [
                "-UITest_unauthorized": "true",
                "-UITest_mockService": "true",
                "-UITest_isHTTP": "true"
            ]
            app.launch()
                    
            
            let errorText = app.staticTexts["loginErrorStaticText"]
            let sheetOpened = errorText.waitForExistence(timeout: 1)
            XCTAssertTrue(sheetOpened)
    }
    
    func test_ContentView_unauthorizedSheet_shouldNotShowUnauthorizedSheet() {
        let app = XCUIApplication()
        app.launchEnvironment = [
            "-UITest_mockService": "true",
            "-UITest_isHTTP": "true"
        ]
        app.launch()
        
        let errorText = app.staticTexts["loginErrorStaticText"]
        let sheetOpened = errorText.waitForExistence(timeout: 1)
        XCTAssertFalse(sheetOpened)
    }

    func test_ContentView_unauthorizedSheet_shouldShowErrorOnReconnectSheet_HTTP() {
        let app = XCUIApplication()
        app.launchEnvironment = [
            "-UITest_unauthorized": "true",
            "-UITest_mockService": "true",
            "-UITest_isHTTP": "true"
        ]
        app.launch()
        
        app.buttons["loginReconnectButton"].tap()
        
        let errorText = app.staticTexts["errorLoginText"]
        let errorExists = errorText.waitForExistence(timeout: 2)
        XCTAssertTrue(errorExists)
    }
    
    func test_ContentView_switchTabs_shouldSwitchTabs() {
        let app = XCUIApplication()
        app.launchEnvironment = [
            "-UITest_unauthorized": "false",
            "-UITest_mockService": "true",
        ]
        app.launch()

        let elementsQuery = app.scrollViews.otherElements
        let homeText = elementsQuery.staticTexts["Top Portfolio Positions"]
        let homeTextExists = homeText.waitForExistence(timeout: 3)
        XCTAssertTrue(homeTextExists)
    
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Portfolio"].tap()
        let portfolioText = elementsQuery.staticTexts["Cash Balances"]
        let portfolioTextExists = portfolioText.waitForExistence(timeout: 3)
        XCTAssertTrue(portfolioTextExists)
        tabBar.buttons["Account"].tap()
        
        let daniilPoletaevStaticText = elementsQuery.staticTexts["accountName"].waitForExistence(timeout: 3)
        XCTAssertTrue(daniilPoletaevStaticText)
        
        tabBar.buttons["Orders"].tap()
        let tradeViewTextExists = elementsQuery.scrollViews.otherElements.staticTexts["Trade Time"].waitForExistence(timeout: 3)
        
        XCTAssertTrue(tradeViewTextExists)        
    }
}
