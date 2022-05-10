//
//  TradesApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 28.03.2022.
//

import Foundation

final class TradesApiService: DataManager, TradesApiServiceProtocol {
    
    func getAllTrades(completion: @escaping (AllTradesResponse) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/iserver/account/orders?force=false")) else {
            return
        }
        let task = self.session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let allTradesResponse = try JSONDecoder().decode(AllTradesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(allTradesResponse)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
