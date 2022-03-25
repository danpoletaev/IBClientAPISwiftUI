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
    private let stream = WebSocketService(url: APIConstants.SOCKET_URL)


    
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
        self.stream.close()
    }
}