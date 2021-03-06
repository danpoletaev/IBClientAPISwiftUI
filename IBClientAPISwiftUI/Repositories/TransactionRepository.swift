//
//  TransactionRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 22.03.2022.
//

import Foundation

protocol TransactionRepositoryProtocol {
    func placeOrder(order: Order, completion: @escaping ([PlaceOrderResponse]) -> ())
    func confirmOrder(id: String, completion: @escaping (([ReplyItem]?, ReplyItemError?)) -> ())
}

final class TransactionRepository: TransactionRepositoryProtocol {
    
    private let apiService: TransactionApiServiceProtocol
    private let accountApiService: AccountApiServiceProtocol
    
    init(apiService: TransactionApiServiceProtocol?, accountApiService: AccountApiServiceProtocol?) {
        let shouldUseMockedService: String = ProcessInfo.processInfo.environment["-UITest_mockService"] ?? "false"
        if shouldUseMockedService == "true" {
            self.apiService = MockTransactionApiService(placeOrderResponse: nil, replyItemResponse: nil)
            self.accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        } else {
            self.apiService = apiService ?? TransactionApiService()
            self.accountApiService = accountApiService ?? AccountApiService()
        }
    }
    
    func placeOrder(order: Order, completion: @escaping ([PlaceOrderResponse]) -> ()) {
        self.accountApiService.fetchAccount { accounts in
            self.apiService.placeOrder(order: order, accountId: accounts[0].accountId) { orderResponse in
                completion(orderResponse)
            }
        }
    }
    
    func confirmOrder(id: String, completion: @escaping (([ReplyItem]?, ReplyItemError?)) -> ()) {
        self.apiService.confirmOrder(id: id) { (replyResponse, error) in
            completion((replyResponse, error))
        }
    }
}
