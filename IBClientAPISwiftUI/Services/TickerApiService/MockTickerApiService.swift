//
//  MockTickerApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import Foundation

class MockTickerApiService: TickerApiServiceProtocol {
    
    let tickerInfo: TickerInfo
    let secDefResponse: SecDefResponse
    let historyConidResponse: HistoryConidResponse
    
    init(tickerInfo: TickerInfo?, secDefResponse: SecDefResponse?, historyConidResponse: HistoryConidResponse?) {
        self.tickerInfo = tickerInfo ?? MockTickerModels.tickerInfo
        self.secDefResponse = secDefResponse ?? MockTickerModels.secDefResponse
        self.historyConidResponse = historyConidResponse ?? MockTickerModels.historyConidResponse
    }
    
    func getTickerInfo(conid: Int, completion: @escaping ([TickerInfo]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion([self.tickerInfo])
        }
    }
    
    func getSecDefByConids(value: [Int], completion: @escaping (SecDefResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.secDefResponse)
        }
    }
    
    func getConidHistory(conid: Int, period: String, completion: @escaping (HistoryConidResponse) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.historyConidResponse)
        }
    }
    
}
