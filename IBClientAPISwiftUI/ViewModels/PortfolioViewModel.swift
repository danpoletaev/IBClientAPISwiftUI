//
//  PortfolioViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class PortfolioViewModel: ObservableObject {
    @Published var positions: [Position] = []
    @Published var assetClass: AssetClass? = nil
    @Published var accountSummary: AccountSummary = [:]
    @Published var dailyPnL: CorePnLModel? = nil
    
    @Published var isLoading = true
    @Published var isPositionsLoading = true
    @Published var isAccountPerformanceLoading = true
    @Published var isAccountSummaryLoading = true
    @Published var isPnlLoading = true
    
    private let repository: PortfolioRepositoryProtocol
    
    init(repository: PortfolioRepositoryProtocol?) {
        self.repository = repository ?? PortfolioRepository(portfolioApiService: nil, accountApiService: nil, tickerApiService: nil )
    }
    
    func fetchPositions() {
        self.repository.fetchPositions { positions in
            self.positions = positions
            self.isPositionsLoading = false
            if (!self.isAccountPerformanceLoading && !self.isAccountSummaryLoading && !self.isPnlLoading) {
                self.isLoading = false
            }
        }
    }
    
    func fetchAccounPerformance() {
        self.repository.fetchAccountAllocation { accountPerformance in
            self.assetClass = accountPerformance.assetClass
            self.isAccountPerformanceLoading = false
            if (!self.isPositionsLoading && !self.isAccountSummaryLoading && !self.isPnlLoading) {
                self.isLoading = false
            }
        }
    }
    
    func fetchAccountSummary() {
        self.repository.getAccountSummary { accountSummary in
            self.accountSummary = accountSummary
            self.isAccountSummaryLoading = false
            if (!self.isPositionsLoading && !self.isAccountPerformanceLoading && !self.isPnlLoading) {
                self.isLoading = false
            }
        }
    }
    
    func getPnL() {
        self.repository.getPnL { coreModel in
            self.dailyPnL = coreModel
            self.isPnlLoading = false
            if (!self.isPositionsLoading && !self.isAccountPerformanceLoading && !self.isAccountSummaryLoading) {
                self.isLoading = false
            }
        }
    }
    
    
    
    func onAppear() {
        if positions.count == 0 {
            fetchPositions()
        }
        fetchAccountSummary()
        fetchAccounPerformance()
        getPnL()
    }
}
