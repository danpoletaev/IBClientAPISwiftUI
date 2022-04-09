//
//  AccountRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol AccountRepositoryProtocol {
    func fetchAccount(completion: @escaping (Account) -> Void)
    func getAccountPerformance(freq: String, completion: @escaping (AccountPerformance) -> Void)
    func getAccountBalances(completion: @escaping (PASummaryResponse) -> Void)
}

final class AccountRepository: AccountRepositoryProtocol {
    private let apiService: AccountApiServiceProtocol
    
    init(apiService: AccountApiServiceProtocol? ) {
        self.apiService = apiService ?? AccountApiService()
    }
    
    func fetchAccount(completion: @escaping (Account) -> Void) {
        apiService.fetchAccount { accounts in
            completion(accounts[0])
        }
    }
    
    
    func getAccountPerformance(freq: String, completion: @escaping (AccountPerformance) -> Void) {
        self.apiService.fetchAccount { accounts in
            self.apiService.getAccountPerformance(accountIds: [accounts[0].accountId], freq: freq) { performanceResponse in
                var reformatedDates: [String] = []
                performanceResponse.nav.dates.forEach { date in
                    reformatedDates.append("\(date[2])\(date[3])-\(date[4])\(date[5])-\(date[6])\(date[7])")
                }
                let lastDate = performanceResponse.nav.data[0].navs[performanceResponse.nav.data[0].navs.count - 1]
                let firstDate = performanceResponse.nav.data[0].navs[0]
                let moneyChange = lastDate - firstDate
                let percentChange = 100 * lastDate/firstDate
                
                completion(AccountPerformance(graphData: performanceResponse.nav.data[0].navs, dates: reformatedDates, moneyChange: moneyChange, percentChange: percentChange))
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
}
