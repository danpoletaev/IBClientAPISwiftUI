//
//  AccountApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class AccountApiService: DataManager, AccountApiServiceProtocol {

    
    func fetchAccount(completion: @escaping ([Account]) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/portfolio/accounts")) else {
            return
        }
        let task = self.session.dataTask(with: url) { data, _, error in
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
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/pa/performance")) else {
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
        
        
        let task = self.session.dataTask(with: request) { data, response, error in
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
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/portfolio/\(accountId)/allocation")) else {
            return
        }
        let task = self.session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let allocation = try JSONDecoder().decode(AllocationResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(allocation)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getAccountSummary(accountId: String, completion: @escaping (AccountSummary) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/portfolio/\(accountId)/summary")) else {
            return
        }
        let task = self.session.dataTask(with: url) { data, _, error in
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
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/iserver/account/pnl/partitioned")) else {
            return
        }
        let task = self.session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let pnlModel = try JSONDecoder().decode(PnLModelResponseModel.self, from: data)
                DispatchQueue.main.async {
                    completion(pnlModel)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getIServerAccount(completion: @escaping((IServerResponse?, NetworkError?)) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/iserver/accounts")) else {
            return
        }
        let task = self.session.dataTask(with: url) { data, response, error in
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
                let iServerResponse = try JSONDecoder().decode(IServerResponse.self, from: data)
                DispatchQueue.main.async {
                    completion((iServerResponse, nil))
                }
            } catch {
                completion((nil, NetworkError.decodeError))
            }
        }
        task.resume()
    }
    
    func tickle(completion: @escaping (TickleResponse) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/tickle")) else {
            return
        }
        let task = self.session.dataTask(with: url) { data, _, error in
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
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/pa/summary")) else {
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
        
        
        let task = self.session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let paSummary = try JSONDecoder().decode(PASummaryResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(paSummary)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
