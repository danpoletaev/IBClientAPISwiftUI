//
//  MockTickerModels.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import Foundation

enum MockTickerModels {
    static let tickerInfo: TickerInfo = Bundle.main.decode(type: [TickerInfo].self, from:  "TickerInfoResponse.json")[0]
    
    static let secDefResponse: SecDefResponse = Bundle.main.decode(type: SecDefResponse.self, from:  "SecDefResponse.json")
    
    static let historyConidResponse: HistoryConidResponse = Bundle.main.decode(type: HistoryConidResponse.self, from:  "HistoryConidResponse.json")
}
