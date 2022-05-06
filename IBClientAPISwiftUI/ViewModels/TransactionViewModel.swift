//
//  TransactionViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 22.03.2022.
//

import Foundation


final class TransactionViewModel: ObservableObject {
    @Published var orders: [PlaceOrderResponse] = []
    
    private let repository: TransactionRepositoryProtocol
    
    init(repository: TransactionRepositoryProtocol?, orders: [PlaceOrderResponse]?) {
        self.repository = repository ?? TransactionRepository(apiService: nil, accountApiService: nil)
        self.orders = orders ?? []
    }
        
    func placeOrder(order: Order, completion: @escaping ([PlaceOrderResponse]) -> ()) {
        self.repository.placeOrder(order: order) { orders in
            self.orders = orders
            completion(orders)
        }
    }
    
    func confirmOrder(id: String, completion: @escaping ([ReplyItem]) -> ()) {
        self.repository.confirmOrder(id: id) { replyResponse in
            completion(replyResponse)
        }
    }
}
