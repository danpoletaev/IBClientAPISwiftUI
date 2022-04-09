//
//  TradesApiService_tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 09.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class TradesApiService_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TradesApiService_getAllTrades_shouldReturnItems() {
        
        let allTradesResponse: AllTradesResponse = MockTradesModels.allTradesResponse
        
        let tradesApiService: TradesApiServiceProtocol = MockTradesApiService(allTradesResponse: allTradesResponse)
        
        tradesApiService.getAllTrades { response in
            XCTAssertEqual(response.orders.count, allTradesResponse.orders.count)
        }
    }
}
