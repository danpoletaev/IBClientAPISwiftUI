//
//  TickerApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol TickerApiServiceProtocol {
    func getTickerInfo(conid: Int, completion: @escaping ([TickerInfo]) -> Void)
    func getSecDefByConids(value: [Int], completion: @escaping (SecDefResponse) -> Void)
    func getConidHistory(conid: Int, period: String, completion: @escaping (HistoryConidResponse) -> ())
}

final class TickerApiService: TickerApiServiceProtocol {
    func getTickerInfo(conid: Int, completion: @escaping ([TickerInfo]) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/iserver/marketdata/snapshot?conids=\(conid)&fields=\(APIConstants.CONID_FIELDS)")) else {
            print("Problem here")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
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
        guard let url = URL(string: APIConstants.BASE_URL.appending("/trsrv/secdef")) else {
            print("Problem here")
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
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let secdefResponse = try JSONDecoder().decode(SecDefResponse.self, from: data)
                DispatchQueue.main.async {
                    print("decoded successfully")
                    completion(secdefResponse)
                }
            } catch {
                print("here problem")
                print(error)
            }
        }
        task.resume()
    }
    
    func getConidHistory(conid: Int, period: String, completion: @escaping (HistoryConidResponse) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/iserver/marketdata/history?conid=\(conid)&period=\(period)")) else {
            print("Problem here")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data =  data, error == nil else {
                return
            }
            do {
                let historyConid = try JSONDecoder().decode(HistoryConidResponse.self, from: data)
                DispatchQueue.main.async {
                    print("decoded successfully")
                    completion(historyConid)
                }
            } catch {
                print("error here")
            }
        }
        task.resume()
    }
}
