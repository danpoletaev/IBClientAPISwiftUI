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
        let shouldUseMockedService: String = ProcessInfo.processInfo.environment["-UITest_mockService"] ?? "false"
        if shouldUseMockedService == "true" {
            self.portfolioApiService = MockPortfolioApiService(positions: nil)
            self.accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
            self.tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        } else {
            self.portfolioApiService = portfolioApiService ?? PortfolioApiService()
            self.accountApiService = accountApiService ?? AccountApiService()
            self.tickerApiService = tickerApiService ?? TickerApiService()
        }
    }
    
    func fetchPositions(completion: @escaping ([Position]) -> Void) {
        self.accountApiService.fetchAccount { accounts in
            self.portfolioApiService.fetchPositions(accountID: accounts[0].accountId) { positions in
                completion(positions)
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
