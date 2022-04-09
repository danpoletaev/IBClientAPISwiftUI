//
//  MockedAccountModels.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import Foundation


enum MockedAccountModels {
    static let account: [Account] = Bundle.main.decode(type: [Account].self, from: "AccountResponse.json")
    
    static let performanceResponse: PerformanceResponse = Bundle.main.decode(type: PerformanceResponse.self, from: "PerformanceResponse.json")
    
    static let allocationResponse: AllocationResponse = Bundle.main.decode(type: AllocationResponse.self, from: "AccountAllocation.json")
    
    static let accountSumary: AccountSummary = Bundle.main.decode(type: AccountSummary.self, from: "AccountSummary.json")
    
    static let pnlModelResponse: PnLModelResponseModel = Bundle.main.decode(type: PnLModelResponseModel.self, from: "PnLResponse.json")
    
    static let tickleResponse: TickleResponse = Bundle.main.decode(type: TickleResponse.self, from: "TickleResponse.json")
    
    static let paSummaryResponse: PASummaryResponse = Bundle.main.decode(type: PASummaryResponse.self, from: "PaSummaryResponse.json")
    
    static let mockedEvnironmentModel = EnvironmentModel(
        accountViewModel: AccountViewModel(
            repository: AccountRepository(
                apiService: MockAccountApiService(
                    accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil)
            )
        )
    )
}
