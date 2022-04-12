//
//  TransactionRepository_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 12.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class TransactionRepository_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TransactionRepository_placeOrder_shouldReturnPlaceOrderResponse() {
        let mockPlaceOrderResponse = MockTransactionModels.placeOrderResponse
        
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        let transactionApiService = MockTransactionApiService(placeOrderResponse: mockPlaceOrderResponse, replyItemResponse: nil)
        let transactionRepository = TransactionRepository(apiService: transactionApiService, accountApiService: accountApiService)
        
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: [PlaceOrderResponse]? = nil
        
        transactionRepository.placeOrder(order: Order(acctId: "UA2222", conid: 1, secType: "STK", orderType: "MKT", side: "BUY", tif: "GTC", quantity: 1.2)) { response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, mockPlaceOrderResponse.count)
        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?[0].id, mockPlaceOrderResponse[0].id)
    }
    
    func test_TransactionRepository_confirmOrder_shouldReturnReplyItem() {
        let replyItemResponse = MockTransactionModels.replyItemResponse
        
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        let transactionApiService = MockTransactionApiService(placeOrderResponse: nil, replyItemResponse: replyItemResponse)
        let transactionRepository = TransactionRepository(apiService: transactionApiService, accountApiService: accountApiService)
        
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: [ReplyItem]? = nil
        
        transactionRepository.confirmOrder(id: "1") { response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, replyItemResponse.count)
        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?[0].orderId, replyItemResponse[0].orderId)
    }

}
