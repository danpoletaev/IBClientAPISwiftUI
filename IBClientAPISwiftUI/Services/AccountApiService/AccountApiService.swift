//
//  AccountApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol AccountApiServiceProtocol {
    func fetchAccount(completion: @escaping ([Account]) -> Void)
    func getAccountPerformance(accountIds: [String], freq: String, completion: @escaping ((PerformanceResponse?, NetworkError?)) -> ())
    func getAccountAllocation(accountId: String, completion: @escaping (AllocationResponse) -> ())
    func getAccountSummary(accountId: String, completion: @escaping (AccountSummary) -> ())
    func getPnL(completion: @escaping (PnLModelResponseModel) -> ())
    func getIServerAccount(completion: @escaping((Any?, NetworkError?)) -> ())
    func tickle(completion: @escaping (TickleResponse) -> ())
    func getCurrentBalance(acctIds: [String], completion: @escaping (PASummaryResponse) -> Void)
    //    func
}

final class AccountApiService: AccountApiServiceProtocol {
    
    func fetchAccount(completion: @escaping ([Account]) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/portfolio/accounts")) else {
            print("Problem here")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let accounts = try JSONDecoder().decode([Account].self, from: data)
                DispatchQueue.main.async {
                    completion(accounts)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getAccountPerformance(accountIds: [String], freq: String, completion: @escaping ((PerformanceResponse?, NetworkError?)) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/pa/performance")) else {
            print("Problem here")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let performancePost = PerformancePostData(acctIds: accountIds, freq: freq)
        
        guard let httpBody = try? JSONEncoder().encode(performancePost) else {
            print("Invalid httpBody")
            return
        }
        
        request.httpBody = httpBody
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode >= 400 && httpResponse.statusCode<500) {
                    completion((nil, NetworkError.unauthorized))
                    return
                }
                else if (httpResponse.statusCode > 500) {
                    completion((nil, NetworkError.serverError))
                    return
                }
            }
            
            do {
                let performanceResponse = try JSONDecoder().decode(PerformanceResponse.self, from: data)
                DispatchQueue.main.async {
                    completion((performanceResponse, nil))
                }
            } catch {
                completion((nil, NetworkError.decodeError))
            }
        }
        task.resume()
    }
    
    func getAccountAllocation(accountId: String, completion: @escaping (AllocationResponse) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/portfolio/\(accountId)/allocation")) else {
            print("Problem here")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let allocation = try JSONDecoder().decode(AllocationResponse.self, from: data)
                DispatchQueue.main.async {
                    print("decoded successfully")
                    completion(allocation)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getAccountSummary(accountId: String, completion: @escaping (AccountSummary) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/portfolio/\(accountId)/summary")) else {
            print("Problem here")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let accountSummary = try JSONDecoder().decode(AccountSummary.self, from: data)
                DispatchQueue.main.async {
                    completion(accountSummary)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getPnL(completion: @escaping (PnLModelResponseModel) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/iserver/account/pnl/partitioned")) else {
            print("Problem here")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let pnlModel = try JSONDecoder().decode(PnLModelResponseModel.self, from: data)
                DispatchQueue.main.async {
                    print("decoded successfully")
                    completion(pnlModel)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getIServerAccount(completion: @escaping((Any?, NetworkError?)) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/iserver/accounts")) else {
            print("Problem here")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion((nil, NetworkError.unauthorized))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode >= 400 && httpResponse.statusCode<500) {
                    completion((nil, NetworkError.unauthorized))
                    return
                }
                else if (httpResponse.statusCode > 500) {
                    completion((nil, NetworkError.serverError))
                    return
                }
            }
            
            do {
                DispatchQueue.main.async {
                    print("i server account called")
                    completion(("hello", nil))
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func tickle(completion: @escaping (TickleResponse) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/tickle")) else {
            print("Problem here")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let tickle = try JSONDecoder().decode(TickleResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(tickle)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getCurrentBalance(acctIds: [String], completion: @escaping (PASummaryResponse) -> Void) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/pa/summary")) else {
            print("Problem here")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let performancePost = SummaryPostData(acctIds: acctIds)
        
        guard let httpBody = try? JSONEncoder().encode(performancePost) else {
            print("Invalid httpBody")
            return
        }
        
        request.httpBody = httpBody
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let paSummary = try JSONDecoder().decode(PASummaryResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(paSummary)
                }
            } catch {
                print("here problem")
                print(error)
            }
        }
        task.resume()
    }
}
