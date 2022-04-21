//
//  AccountApiServiceProtocol.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 17.04.2022.
//

import Foundation

protocol AccountApiServiceProtocol {
    func fetchAccount(completion: @escaping ([Account]) -> Void)
    func getAccountPerformance(accountIds: [String], freq: String, completion: @escaping ((PerformanceResponse?, NetworkError?)) -> ())
    func getAccountAllocation(accountId: String, completion: @escaping (AllocationResponse) -> ())
    func getAccountSummary(accountId: String, completion: @escaping (AccountSummary) -> ())
    func getPnL(completion: @escaping (PnLModelResponseModel) -> ())
    func getIServerAccount(completion: @escaping((IServerResponse?, NetworkError?)) -> ())
    func tickle(completion: @escaping (TickleResponse) -> ())
    func getCurrentBalance(acctIds: [String], completion: @escaping (PASummaryResponse) -> Void)
}
