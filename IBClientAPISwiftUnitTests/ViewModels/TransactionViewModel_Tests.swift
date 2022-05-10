//
//  TransactionViewModel_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 13.04.2022.
//

import XCTest
import Combine
@testable import IBClientAPISwiftUI

class TransactionViewModel_Tests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TransactionViewModel_placeOrder_shouldSetOrders() {
        let placeOrders = MockTransactionModels.placeOrderResponse
        
        let transactionApiService = MockTransactionApiService(placeOrderResponse: placeOrders, replyItemResponse: nil)
        
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let transactionRepository = TransactionRepository(apiService: transactionApiService, accountApiService: accountApiService)
        let transactionViewModel = TransactionViewModel(repository: transactionRepository, orders: nil)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: [PlaceOrderResponse]? = nil
        
        transactionViewModel.$orders
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        transactionViewModel.placeOrder(order: Order(acctId: "UA11", conid: 1, secType: "STK", orderType: "MKT", side: "BUY", tif: "GTC", quantity: 1.2)) {recievedValue in}
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, placeOrders.count)
        XCTAssertEqual(result?[0].id, placeOrders[0].id)
    }
    
    func test_TransactionViewModel_placeOrder_shouldReturnOrders() {
        let placeOrders = MockTransactionModels.placeOrderResponse
        
        let transactionApiService = MockTransactionApiService(placeOrderResponse: placeOrders, replyItemResponse: nil)
        
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let transactionRepository = TransactionRepository(apiService: transactionApiService, accountApiService: accountApiService)
        let transactionViewModel = TransactionViewModel(repository: transactionRepository, orders: nil)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: [PlaceOrderResponse]? = nil
        
        transactionViewModel.placeOrder(order: Order(acctId: "UA11", conid: 1, secType: "STK", orderType: "MKT", side: "BUY", tif: "GTC", quantity: 1.2)) {recievedValue in
            result = recievedValue
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, placeOrders.count)
        XCTAssertEqual(result?[0].id, placeOrders[0].id)
    }
    
    func test_TransactionViewModel_confirmOrder_shouldReturnReplyItem() {
        let replyMock = MockTransactionModels.replyItemResponse
        
        let transactionApiService = MockTransactionApiService(placeOrderResponse: nil, replyItemResponse: replyMock)
        
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let transactionRepository = TransactionRepository(apiService: transactionApiService, accountApiService: accountApiService)
        let transactionViewModel = TransactionViewModel(repository: transactionRepository, orders: nil)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: [ReplyItem]? = nil
        
        transactionViewModel.confirmOrder(id: "1") { (replyItems, error) in
            result = replyItems
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, replyMock.count)
    }

}
