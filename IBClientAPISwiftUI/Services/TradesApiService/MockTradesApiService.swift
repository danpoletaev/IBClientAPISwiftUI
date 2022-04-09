//
//  MockTradesApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 09.04.2022.
//

import Foundation

class MockTradesApiService: TradesApiServiceProtocol {
    
    let allTradesResponse: AllTradesResponse
    
    init(allTradesResponse: AllTradesResponse?) {
        self.allTradesResponse = allTradesResponse ?? MockTradesModels.allTradesResponse
    }
    
    func getAllTrades(completion: @escaping (AllTradesResponse) -> ()) {
        completion(allTradesResponse)
    }
    
}
