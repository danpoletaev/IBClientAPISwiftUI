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
    
    init(repository: TransactionRepositoryProtocol = TransactionRepository()) {
        self.repository = repository
    }
        
    func placeOrder(order: Order) {
        self.repository.placeOrder(order: order) { orders in
            self.orders = orders
            print(orders)
        }
    }
}
