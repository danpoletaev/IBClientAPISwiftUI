//
//  TickerApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class TickerApiService: DataManager, TickerApiServiceProtocol {
    
    func getTickerInfo(conid: Int, completion: @escaping ([TickerInfo]) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/iserver/marketdata/snapshot?conids=\(conid)&fields=\(APIConstants.CONID_FIELDS)")) else {
            return
        }
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let tickerInfo = try JSONDecoder().decode([TickerInfo].self, from: data)
                DispatchQueue.main.async {
                    completion(tickerInfo)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func getSecDefByConids(value: [Int], completion: @escaping (SecDefResponse) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/trsrv/secdef")) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let secdefInfo = SecDefPostData(conids: value)
        
        guard let httpBody = try? JSONEncoder().encode(secdefInfo) else {
            print("Invalid httpBody")
            return
        }
        
        request.httpBody = httpBody
        
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let secdefResponse = try JSONDecoder().decode(SecDefResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(secdefResponse)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getConidHistory(conid: Int, period: String, completion: @escaping (HistoryConidResponse) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/iserver/marketdata/history?conid=\(conid)&period=\(period)")) else {
            return
        }
        let task = session.dataTask(with: url) { data, _, error in
            guard let data =  data, error == nil else {
                return
            }
            do {
                let historyConid = try JSONDecoder().decode(HistoryConidResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(historyConid)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
