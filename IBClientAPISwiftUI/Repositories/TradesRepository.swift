//
//  TradesRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 28.03.2022.
//

import Foundation

protocol TradesRepositoryProtocol {
    func getAllTrades(completion: @escaping (AllTradesResponse) -> ())
}

final class TradesRepository: TradesRepositoryProtocol {
    private let apiService: TradesApiServiceProtocol
    
    init(apiService: TradesApiServiceProtocol?) {
        self.apiService = apiService ?? TradesApiService()
    }
    
    func getAllTrades(completion: @escaping (AllTradesResponse) -> ()) {
        self.apiService.getAllTrades { allTrades in
            completion(allTrades)
        }
    }
}
