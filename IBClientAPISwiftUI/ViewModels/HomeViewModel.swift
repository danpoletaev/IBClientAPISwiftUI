//
//  HomeViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var topPortfolio: [Position] = []
    @Published var accountPerformance: AccountPerformance = AccountPerformance(graphData: [], dates: [], moneyChange: 0, percentChange: 0)
    @Published var secDefConids : [SecDefConid] = []
    
    //loaders
    @Published var isGraphLoading = true
    @Published var topPortfolioLoading = true
    @Published var dailyGainersLoading = true
    @Published var isLoading = true
    
    private let homeRepository: HomeRepositoryProtocol
    
    init(homeRepository: HomeRepositoryProtocol?) {
        self.homeRepository = homeRepository ?? HomeRepository(homeApiService: nil, portfolioApiService: nil, tickerApiService: nil, accountApiService: nil)
    }
    
    private func getTopPositions() {
        self.homeRepository.fetchTopPositions { topPositions in
            self.topPortfolio = topPositions
            self.topPortfolioLoading = false
            if !self.isGraphLoading && !self.dailyGainersLoading {
                self.isLoading = false
            }
        }
    }
    
    private func getDailyGainers() {
        self.homeRepository.fetchDailyGainers { (conidsSecDef, error) in
            if (conidsSecDef != nil) {
                self.secDefConids = conidsSecDef!
            }
            DispatchQueue.main.async {
                self.dailyGainersLoading = false
                if !self.isGraphLoading && !self.topPortfolioLoading {
                    self.isLoading = false
                }
            }
        }
    }
    
    private func getAccountPerformance() {
        self.homeRepository.fetchAccountPerformance { (accountPerformance, error) in
            DispatchQueue.main.async {
                self.isGraphLoading = false
                if !self.dailyGainersLoading && !self.topPortfolioLoading {
                    self.isLoading = false
                }
            }
            
            if (accountPerformance != nil) {
                self.accountPerformance = accountPerformance!
            }
        }
    }
    
    func onAppear() {
        self.homeRepository.calliServer()
        if (topPortfolio.count == 0) {
            getTopPositions()
        }
        if (secDefConids.count == 0) {
            getDailyGainers()
        }
        getAccountPerformance()
    }
}
