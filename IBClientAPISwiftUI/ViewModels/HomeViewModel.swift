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
    
    private let homeRepository: HomeRepositoryProtocol
    
    init(homeRepository: HomeRepositoryProtocol = HomeRepository()) {
        self.homeRepository = homeRepository
    }
    
    private func getTopPositions() {
        self.homeRepository.fetchTopPositions { topPositions in
            self.topPortfolio = topPositions
        }
    }
    
    private func getDailyGainers() {
        self.homeRepository.fetchDailyGainers { conidsSecDef in
            self.secDefConids = conidsSecDef
        }
    }
    
    private func getAccountPerformance() {
        self.homeRepository.fetchAccountPerformance { accountPerformance in
            self.accountPerformance = accountPerformance
        }
    }
    
    func onAppear() {
        self.homeRepository.calliServer()
        getTopPositions()
        getDailyGainers()
        getAccountPerformance()
    }
}
