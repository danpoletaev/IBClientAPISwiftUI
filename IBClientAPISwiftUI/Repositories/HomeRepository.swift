//
//  HomeRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchTopPositions(completion: @escaping ([Position]) -> Void)
    func fetchDailyGainers(completion: @escaping (([SecDefConid]?, NetworkError?)) -> Void)
    func fetchAccountPerformance(completion: @escaping ((AccountPerformance?, NetworkError?)) -> Void)
    func calliServer()
}

final class HomeRepository: HomeRepositoryProtocol {
    private let homeApiService: HomeApiServiceProtocol
    private let portfolioApiService: PortfolioApiServiceProtocol
    private let tickerApiService: TickerApiServiceProtocol
    private let accountApiService: AccountApiServiceProtocol
    
    init(homeApiService: HomeApiServiceProtocol?, portfolioApiService: PortfolioApiServiceProtocol?, tickerApiService: TickerApiServiceProtocol?, accountApiService: AccountApiServiceProtocol?) {
        self.homeApiService = homeApiService ?? HomeApiService()
        self.portfolioApiService = portfolioApiService ?? PortfolioApiService()
        self.tickerApiService = tickerApiService ?? TickerApiService()
        self.accountApiService = accountApiService ?? AccountApiService()
    }
    
    func fetchTopPositions(completion: @escaping ([Position]) -> Void) {
        self.accountApiService.fetchAccount { accounts in
            self.portfolioApiService.fetchPositions(accountID: accounts[0].accountId) { positions in
                var tempPositions: [Position] = []
                let filtered = positions.sorted {
                    $0.position ?? 0 > $1.position ?? 0
                }
                var slicedPositions: [Position]
                if (filtered.count > 3) {
                    slicedPositions = Array(filtered[0...2])
                } else {
                    slicedPositions = positions
                }
                if (positions.count == 0) {
                    completion(positions)
                }
                slicedPositions.forEach { position in
                    var tempPosition = position
                    self.tickerApiService.getTickerInfo(conid: position.conid) { tickerInfo in
                        tempPosition.priceChange = tickerInfo[0].changeFromLastPrice
                        tempPositions.append(tempPosition)
                        completion(tempPositions)
                    }
                }
            }
        }
    }
    
    func fetchAccountPerformance(completion: @escaping ((AccountPerformance?, NetworkError?)) -> Void) {
        self.accountApiService.fetchAccount { accounts in
            self.accountApiService.getAccountPerformance(accountIds: [accounts[0].accountId], freq: "Q") { (performanceResponse, error) in
                if (performanceResponse != nil) {
                    var reformatedDates: [String] = []
                    performanceResponse!.nav.dates.forEach { date in
                        reformatedDates.append("\(date[2])\(date[3])-\(date[4])\(date[5])-\(date[6])\(date[7])")
                    }
                    let lastDate = performanceResponse!.nav.data[0].navs[performanceResponse!.nav.data[0].navs.count - 1]
                    let firstDate = performanceResponse!.nav.data[0].navs[0]
                    let moneyChange = lastDate - firstDate
                    let percentChange = 100 * lastDate/firstDate
        
                    completion((AccountPerformance(graphData: performanceResponse!.nav.data[0].navs, dates: reformatedDates, moneyChange: moneyChange, percentChange: percentChange), nil))
                } else {
                    completion((nil, error))
                }
            }
        }
    }
    
    func fetchDailyGainers(completion: @escaping (([SecDefConid]?, NetworkError?)) -> Void) {
        self.homeApiService.getScannerConids { (scannerResponse, error) in
            if (scannerResponse != nil) {
                let contracts = scannerResponse!.Contracts.Contract
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
                            completion((tempSecdefs, nil))
                        }
                    }
                }
            } else {
                completion((nil, error))
            }
        }
    }
    
    func calliServer() {
        self.accountApiService.getIServerAccount() { compl in}
    }
}
