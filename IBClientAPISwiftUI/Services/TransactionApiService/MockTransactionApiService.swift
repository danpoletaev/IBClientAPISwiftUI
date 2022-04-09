//
//  MockTransactionApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 09.04.2022.
//

import Foundation

class MockTransactionApiService: TransactionApiServiceProtocol {
    
    let placeOrderResponse: [PlaceOrderResponse]
    let replyItemResponse: [ReplyItem]
    
    init (placeOrderResponse: [PlaceOrderResponse]?, replyItemResponse: [ReplyItem]?) {
        self.placeOrderResponse = placeOrderResponse ?? MockTransactionModels.placeOrderResponse
        self.replyItemResponse = replyItemResponse ?? MockTransactionModels.replyItemResponse
    }
    
    func placeOrder(order: Order, accountId: String, completion: @escaping ([PlaceOrderResponse]) -> ()) {
        completion(placeOrderResponse)
    }
    
    func confirmOrder(id: String, completion: @escaping ([ReplyItem]) -> ()) {
        completion(replyItemResponse)
    }
    
    
}
