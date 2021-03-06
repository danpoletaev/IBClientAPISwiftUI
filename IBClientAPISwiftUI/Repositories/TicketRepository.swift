//
//  TicketRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol TicketRepositoryProtocol {
    func getTickerInfo(conid: Int, completion: @escaping (TickerInfo) -> Void)
    func getConidHistory(conid: Int, period: String, completion: @escaping (AccountPerformance) -> Void)
    func tickle(completion: @escaping (TickleResponse) -> Void)
}

final class TicketRepository: TicketRepositoryProtocol {
    private let apiService: TickerApiServiceProtocol
    private let accountApiService: AccountApiServiceProtocol
    
    init(apiService: TickerApiServiceProtocol?, acccountApiService: AccountApiServiceProtocol?) {
        let shouldUseMockedService: String = ProcessInfo.processInfo.environment["-UITest_mockService"] ?? "false"
        if shouldUseMockedService == "true" {
            self.apiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
            self.accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        } else {
            self.apiService = apiService ?? TickerApiService()
            self.accountApiService = acccountApiService ?? AccountApiService()
        }
    }
    
    func getTickerInfo(conid: Int, completion: @escaping (TickerInfo) -> Void) {
        self.apiService.getTickerInfo(conid: conid) { tickerInfos in
            completion(tickerInfos[0])
        }
    }
    
    func getConidHistory(conid: Int, period: String, completion: @escaping (AccountPerformance) -> Void) {
        self.apiService.getConidHistory(conid: conid, period: period) { history in
            var tempGraphData: [Double] = []
            var tempDates: [String] = []
            let formatter = DateFormatter()
            formatter.dateFormat = "yy-MM-dd"
            history.data.forEach { barItem in
                tempGraphData.append(barItem.c)
                let tempDate = NSDate(timeIntervalSince1970: barItem.t)
                let tempDateToString = formatter.string(from: tempDate as Date)
                tempDates.append(tempDateToString)
            }
            completion(AccountPerformance(graphData: tempGraphData, dates: tempDates, moneyChange: nil, percentChange: nil))
        }
    }
    
    func tickle(completion: @escaping (TickleResponse) -> Void) {
        self.accountApiService.tickle { tickle in
            completion(tickle)
        }
    }
}
