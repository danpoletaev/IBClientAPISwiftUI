//
//  AccountRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol AccountRepositoryProtocol {
    func fetchAccount(completion: @escaping (Account) -> Void)
    func getAccountPerformance(accountIds: [String], freq: String, completion: @escaping ((AccountPerformance?, NetworkError?)) -> ())
    func getAccountBalances(completion: @escaping (PASummaryResponse) -> Void)
    func getIServerAccount(completion: @escaping((IServerResponse?, NetworkError?)) -> ())
}

final class AccountRepository: AccountRepositoryProtocol {
    private let apiService: AccountApiServiceProtocol
    
    init(apiService: AccountApiServiceProtocol?) {
        let shouldUseMockedService: String = ProcessInfo.processInfo.environment["-UITest_mockService"] ?? "false"
        let shouldReturnUnauthorize: String = ProcessInfo.processInfo.environment["-UITest_unauthorized"] ?? "false"
        if shouldUseMockedService == "true" {
            self.apiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: shouldReturnUnauthorize == "true" ? (nil, NetworkError.unauthorized) : nil)
        } else {
            self.apiService = apiService ?? AccountApiService()
        }
    }
    
    func fetchAccount(completion: @escaping (Account) -> Void) {
        apiService.fetchAccount { accounts in
            completion(accounts[0])
        }
    }
    
    
    func getAccountPerformance(accountIds: [String], freq: String, completion: @escaping ((AccountPerformance?, NetworkError?)) -> ()) {
        self.apiService.fetchAccount { accounts in
            self.apiService.getAccountPerformance(accountIds: [accounts[0].accountId], freq: freq) { (performanceResponse, error) in
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
    
    func getAccountBalances(completion: @escaping (PASummaryResponse) -> Void) {
        self.fetchAccount { account in
            self.apiService.getCurrentBalance(acctIds: [account.accountId]) { response in
                completion(response)
            }
        }
    }
    
    func getIServerAccount(completion: @escaping ((IServerResponse?, NetworkError?)) -> ()) {
        self.apiService.getIServerAccount{ (response, error) in
            completion((response, error))
        }
    }
}
