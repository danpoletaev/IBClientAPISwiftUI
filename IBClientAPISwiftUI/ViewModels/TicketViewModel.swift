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
    
    @Published var isLoading = true
    
    private let stream = WebSocketService(url: APIConstants.SOCKET_URL)
    
    private let repository: TicketRepositoryProtocol
    
    init(repository: TicketRepositoryProtocol?) {
        self.repository = repository ?? TicketRepository(apiService: nil, acccountApiService: nil)
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
    
    func loadTickerInfoFromSocket(conid: Int) {
        self.repository.tickle { tickle in
            let authorizeMessageStr = "{\"session\":\"\(tickle.session)\"}"
            self.stream.authorize(token: authorizeMessageStr)
            
            self.stream.sendRepeatedly(message: "smd+\(conid)+{\"fields\":\(APIConstants.STRING_FIELDS)}")
        }
    }
    
    func retrieveMessages() async {
        do {
            for try await message in stream {
                do {
                    let tickerInfo = try message.tickerInfo()
                    DispatchQueue.main.async {
                        self.tickerInfo = self.tickerInfo?.combine(newTicket: tickerInfo) ?? tickerInfo
                        self.isLoading = false
                    }
                } catch {
                    continue
                }
            }
        } catch {
            debugPrint("Oops something didn't go right")
        }
    }
    
    func onAppear(conid: Int, period: String) {
        
        loadTickerInfoFromSocket(conid: conid)
        
        getTickerHistory(conid: conid, period: period)
    }
    
    func onDisappear() {
        print("Connection should be closed")
        self.stream.close()
    }
}
