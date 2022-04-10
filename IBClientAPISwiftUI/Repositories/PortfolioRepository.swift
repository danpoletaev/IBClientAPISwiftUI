//
//  PortfolioRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol PortfolioRepositoryProtocol {
    func fetchPositions(completion: @escaping ([Position]) -> Void)
    func fetchAccountAllocation(completion: @escaping (AllocationResponse) -> Void)
    func getAccountSummary(completion: @escaping (AccountSummary) -> ())
    func getPnL(completion: @escaping (CorePnLModel) -> ())
}

final class PortfolioRepository: PortfolioRepositoryProtocol {
    private let portfolioApiService: PortfolioApiServiceProtocol
    private let accountApiService: AccountApiServiceProtocol
    private let tickerApiService: TickerApiServiceProtocol
    
    init(portfolioApiService: PortfolioApiServiceProtocol?, accountApiService: AccountApiServiceProtocol?, tickerApiService: TickerApiServiceProtocol?) {
        self.portfolioApiService = portfolioApiService ?? PortfolioApiService()
        self.accountApiService = accountApiService ?? AccountApiService()
        self.tickerApiService = tickerApiService ?? TickerApiService()
    }
    
    func fetchPositions(completion: @escaping ([Position]) -> Void) {
        self.accountApiService.fetchAccount { accounts in
            self.portfolioApiService.fetchPositions(accountID: accounts[0].accountId) { positions in
                var tempPositions: [Position] = []
                if positions.count == 0 {
                    completion(positions)
                }
                positions.forEach { position in
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
    
    func fetchAccountAllocation(completion: @escaping (AllocationResponse) -> Void) {
        self.accountApiService.fetchAccount { account in
            self.accountApiService.getAccountAllocation(accountId: account[0].accountId) { allocationResponse in
                completion(allocationResponse)
            }
        }
    }
    
    func getAccountSummary(completion: @escaping (AccountSummary) -> ()) {
        self.accountApiService.fetchAccount { account in
            self.accountApiService.getAccountSummary(accountId: account[0].accountId) { accountSummary in
                completion(accountSummary)
            }
        }
    }
    
    func getPnL(completion: @escaping (CorePnLModel) -> ()) {
        self.accountApiService.getPnL { pnlResponse in
            if let pnl = pnlResponse.upnl.first {
                completion(pnl.value)
            }
        }
    }
}
