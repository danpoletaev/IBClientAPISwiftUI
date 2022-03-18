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
    
    private let repository: PortfolioRepositoryProtocol
    
    init(repository: PortfolioRepositoryProtocol = PortfolioRepository()) {
        self.repository = repository
    }
    
    func fetchPositions() {
        self.repository.fetchPositions { positions in
            self.positions = positions
        }
    }
    
    func fetchAccounPerformance() {
        self.repository.fetchAccountAllocation { accountPerformance in
            self.assetClass = accountPerformance.assetClass
        }
    }
    
    func fetchAccountSummary() {
        self.repository.getAccountSummary { accountSummary in
            self.accountSummary = accountSummary
        }
    }
    
    func getPnL() {
        self.repository.getPnL { coreModel in
            print(coreModel)
            self.dailyPnL = coreModel
        }
    }
    
    
    
    func onAppear() {
        fetchPositions()
        fetchAccountSummary()
        fetchAccounPerformance()
        getPnL()
    }
}
