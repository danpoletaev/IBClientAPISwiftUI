//
//  TicketViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class TicketViewModel: ObservableObject {
    @Published var tickerInfo: TickerInfo? = nil
    @Published var graphData: [Double] = []
    @Published var dates: [String] = []
    
    private let repository: TicketRepositoryProtocol
    
    init(repository: TicketRepositoryProtocol = TicketRepository()) {
        self.repository = repository
    }
    
    func getTickerInfo(conid: Int) {
        self.repository.getTickerInfo(conid: conid) { tickerInfo in
            self.tickerInfo = tickerInfo
        }
    }
    
    func getTickerHistory(conid: Int, period: String) {
        self.repository.getConidHistory(conid: conid, period: period) { tickerPerformance in
            self.graphData = tickerPerformance.graphData
            self.dates = tickerPerformance.dates
        }
    }
    
    func onAppear(conid: Int, period: String) {
        getTickerInfo(conid: conid)
        
        getTickerHistory(conid: conid, period: period)
    }
}
