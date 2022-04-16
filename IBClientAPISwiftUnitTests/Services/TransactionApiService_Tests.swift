//
//  TransactionApiService_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 09.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class TransactionApiService_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TransactionApiService_placeOrder_shouldReturnItems() {
        
        let placeOrderResponse: [PlaceOrderResponse] = MockTransactionModels.placeOrderResponse
        
        let transactionApiService: TransactionApiServiceProtocol = MockTransactionApiService(placeOrderResponse: placeOrderResponse, replyItemResponse: nil)
        
        transactionApiService.placeOrder(order: Order(acctId: "2222", conid: 2, secType: "STK", orderType: "MKT", side: "BUY", tif: "GTC", quantity: 1.23), accountId: "UA12131") { response in
            XCTAssertEqual(placeOrderResponse.count, response.count)
        }
    }
    
    func test_TransactionApiService_confirmOrder_shouldReturnItems() {
        
        let replyItemResponse: [ReplyItem] = MockTransactionModels.replyItemResponse
        
        let transactionApiService: TransactionApiServiceProtocol = MockTransactionApiService(placeOrderResponse: nil, replyItemResponse: replyItemResponse)
        
        transactionApiService.confirmOrder(id: "11") { response in
            XCTAssertEqual(replyItemResponse.count, response.count)
        }
    }
}
