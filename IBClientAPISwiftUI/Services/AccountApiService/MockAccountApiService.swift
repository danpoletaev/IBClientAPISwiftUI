//
//  MockAccountApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import Foundation


class MockAccountApiService: AccountApiServiceProtocol {
    
    let accountTestData: [Account]
    let accountPerformanceTestData: PerformanceResponse
    let testAccountId: Int = 1
    let allocationTestResponse: AllocationResponse
    let accountSummaryTest: AccountSummary
    let pnlModelResponseTest: PnLModelResponseModel
    let testTickleResponse: TickleResponse
    let paSummaryResponse: PASummaryResponse
    
    init(accountTestData: [Account]?, accountPerformanceTestData: PerformanceResponse?, allocationTestResponse: AllocationResponse?, accountSummaryTest: AccountSummary?, pnlModelResponseTest: PnLModelResponseModel?, testTickleResponse: TickleResponse?, paSummaryResponse: PASummaryResponse?) {
        self.accountTestData = accountTestData ?? MockedAccountModels.account
        
        self.accountPerformanceTestData = accountPerformanceTestData ?? MockedAccountModels.performanceResponse
        
        self.allocationTestResponse = allocationTestResponse ?? MockedAccountModels.allocationResponse
        
        self.accountSummaryTest = accountSummaryTest ?? MockedAccountModels.accountSumary
        
        self.pnlModelResponseTest = pnlModelResponseTest ?? MockedAccountModels.pnlModelResponse
        
        self.testTickleResponse = testTickleResponse ?? MockedAccountModels.tickleResponse
        
        self.paSummaryResponse = paSummaryResponse ?? MockedAccountModels.paSummaryResponse
    }
    
    func fetchAccount(completion: @escaping ([Account]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.accountTestData)
        }
    }
    
    func getAccountPerformance(accountIds: [String], freq: String, completion: @escaping ((PerformanceResponse?, NetworkError?)) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion((self.accountPerformanceTestData, nil))
        }
    }
    
    
    func getAccountAllocation(accountId: String, completion: @escaping (AllocationResponse) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.allocationTestResponse)
        }
    }
    
    func getAccountSummary(accountId: String, completion: @escaping (AccountSummary) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.accountSummaryTest)
        }
    }
    
    func getPnL(completion: @escaping (PnLModelResponseModel) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.pnlModelResponseTest)
        }
    }
    
    func getIServerAccount(completion: @escaping((Any?, NetworkError?)) -> ()) {
        completion((nil, nil))
    }
    
    func tickle(completion: @escaping (TickleResponse) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.testTickleResponse)
        }
    }
    
    func getCurrentBalance(acctIds: [String], completion: @escaping (PASummaryResponse) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.paSummaryResponse)
        }
    }
}
