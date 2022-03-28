//
//  TradesApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 28.03.2022.
//

import Foundation

protocol TradesApiServiceProtocol {
    func getAllTrades(completion: @escaping (AllTradesResponse) -> ())
}


final class TradesApiService: TradesApiServiceProtocol {
    func getAllTrades(completion: @escaping (AllTradesResponse) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/iserver/account/orders?force=false")) else {
            print("Problem here")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let allTradesResponse = try JSONDecoder().decode(AllTradesResponse.self, from: data)
                DispatchQueue.main.async {
                    print("decoded successfully")
                    completion(allTradesResponse)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
