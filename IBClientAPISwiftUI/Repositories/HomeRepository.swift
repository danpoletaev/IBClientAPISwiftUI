//
//  HomeRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchTopPositions(completion: @escaping ([Position]) -> Void)
    func fetchDailyGainers(completion: @escaping ([SecDefConid]) -> Void)
    func fetchAccountPerformance(completion: @escaping (AccountPerformance) -> Void)
    func calliServer()
}

final class HomeRepository: HomeRepositoryProtocol {
    private let homeApiService: HomeApiServiceProtocol
    private let portfolioApiService: PortfolioApiServiceProtocol
    private let tickerApiService: TickerApiServiceProtocol
    private let accountApiService: AccountApiServiceProtocol
    
    init(homeApiService: HomeApiServiceProtocol = HomeApiService(), portfolioApiService: PortfolioApiServiceProtocol = PortfolioApiService(), tickerApiService: TickerApiServiceProtocol = TickerApiService(), accountApiService: AccountApiServiceProtocol = AccountApiService()) {
        self.homeApiService = homeApiService
        self.portfolioApiService = portfolioApiService
        self.tickerApiService = tickerApiService
        self.accountApiService = accountApiService
    }
    
    func fetchTopPositions(completion: @escaping ([Position]) -> Void) {
        self.accountApiService.fetchAccount { accounts in
            self.portfolioApiService.fetchPositions(accountID: accounts[0].accountId) { positions in
                let filtered = positions.sorted {
                    $0.position ?? 0 > $1.position ?? 0
                }
                let slicedPositions = filtered[0...2]
                completion(Array(slicedPositions))
            }
        }
    }
    
    func fetchAccountPerformance(completion: @escaping (AccountPerformance) -> Void) {
        self.accountApiService.fetchAccount { accounts in
            self.accountApiService.getAccountPerformance(accountIds: [accounts[0].accountId], freq: "Q") { performanceResponse in
                var reformatedDates: [String] = []
                performanceResponse.nav.dates.forEach { date in
                    reformatedDates.append("\(date[2])\(date[3])-\(date[4])\(date[5])-\(date[6])\(date[7])")
                }
                completion(AccountPerformance(graphData: performanceResponse.nav.data[0].navs, dates: reformatedDates))
            }
        }
    }
    
    func fetchDailyGainers(completion: @escaping ([SecDefConid]) -> Void) {
        self.homeApiService.getScannerConids { scannerResponse in
            let contracts = scannerResponse.Contracts.Contract
            var conids: [Int] = []
            for i in 0...5 {
                if let tempConid = Int(contracts[i].contractID) {
                    conids.append(tempConid)
                }
            }
            
            var tempSecdefs: [SecDefConid] = []
            
            self.tickerApiService.getSecDefByConids(value: conids) { secdefResponse in
                for contract in secdefResponse.secdef {
                    self.tickerApiService.getTickerInfo(conid: contract.conid) { tickerInfo in
                        tempSecdefs.append(SecDefConid(conid: contract.conid, currency: contract.currency, listingExchange: contract.listingExchange, name: contract.name, assetClass: contract.assetClass, ticker: contract.ticker, lastPrice: tickerInfo[0].bid, percentChange: tickerInfo[0].changeFromLastPricePercentage))
                        completion(tempSecdefs)
                    }
                }
            }
        }
    }
    
    func calliServer() {
        self.accountApiService.getIServerAccount()
    }
}
