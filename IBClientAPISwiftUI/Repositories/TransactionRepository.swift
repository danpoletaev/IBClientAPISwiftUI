//
//  TransactionRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 22.03.2022.
//

import Foundation

protocol TransactionRepositoryProtocol {
    func placeOrder(order: Order, completion: @escaping ([PlaceOrderResponse]) -> ())
}

final class TransactionRepository: TransactionRepositoryProtocol {
    
    private let apiService: TransactionApiServiceProtocol
    private let accountApiService: AccountApiServiceProtocol
    
    init(apiService: TransactionApiServiceProtocol = TransactionApiService(), accountApiService: AccountApiServiceProtocol = AccountApiService()) {
        self.apiService = apiService
        self.accountApiService = accountApiService
    }
    
    func placeOrder(order: Order, completion: @escaping ([PlaceOrderResponse]) -> ()) {
        self.accountApiService.fetchAccount { accounts in
            self.apiService.placeOrder(order: order, accountId: accounts[0].accountId) { orderResponse in
                completion(orderResponse)
            }
        }
    }
}
