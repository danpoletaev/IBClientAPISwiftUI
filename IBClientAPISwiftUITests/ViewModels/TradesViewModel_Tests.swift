//
//  TradesViewModel_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 13.04.2022.
//

import XCTest
import Combine
@testable import IBClientAPISwiftUI

class TradesViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TradesViewModel_getAllTrades_shouldSetAllTrades() {
        let mockAllTrades = MockTradesModels.allTradesResponse
        
        let tradesApiService = MockTradesApiService(allTradesResponse: mockAllTrades)
        let tradesRepository = TradesRepository(apiService: tradesApiService)
        let tradesViewModel = TradesViewModel(repository: tradesRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: AllTradesResponse? = nil
        
        tradesViewModel.$allTrades
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        tradesViewModel.getAllTrades()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.orders.count, mockAllTrades.orders.count)
        XCTAssertEqual(result?.orders[0].companyName, mockAllTrades.orders[0].companyName)
    }

}
