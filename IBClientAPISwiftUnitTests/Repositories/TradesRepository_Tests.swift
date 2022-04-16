//
//  TradesRepository_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 12.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class TradesRepository_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TradesRepository_getAllTrades_shouldReturnAllTrades() {
        let allTradesResponse = MockTradesModels.allTradesResponse
        
        let tradesRepository = TradesRepository(apiService: MockTradesApiService(allTradesResponse: allTradesResponse))
        
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: AllTradesResponse? = nil
        
        tradesRepository.getAllTrades { response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.orders.count, allTradesResponse.orders.count)
    }

}
