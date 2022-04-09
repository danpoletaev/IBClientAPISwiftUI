//
//  TradesViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 28.03.2022.
//

import Foundation

final class TradesViewModel: ObservableObject {
    @Published var allTrades: AllTradesResponse = AllTradesResponse(orders: [])
    
    private let repository: TradesRepositoryProtocol
    
    init(repository: TradesRepositoryProtocol?) {
        self.repository = repository ?? TradesRepository(apiService: nil)
    }
    
    func getAllTrades() {
        self.repository.getAllTrades { allTrades in
            let sortedTrades = allTrades.orders.sorted {
                $0.lastExecutionTime_r > $1.lastExecutionTime_r
            }
            self.allTrades = AllTradesResponse(orders: sortedTrades)
        }
    }
    
}

