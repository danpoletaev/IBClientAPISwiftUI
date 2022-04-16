//
//  PortfolioApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol PortfolioApiServiceProtocol {
    func fetchPositions(accountID: String, completion: @escaping ([Position]) -> Void)
}

final class PortfolioApiService: DataManager, PortfolioApiServiceProtocol {
    func fetchPositions(accountID: String, completion: @escaping ([Position]) -> Void) {
        guard let url = URL(string: self.API_URL.appending("/portfolio/\(accountID)/positions/0"))  else {
            print("Problem here")
            return
        }
        let task = self.session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let positions = try JSONDecoder().decode([Position].self, from: data)
                DispatchQueue.main.async {
                    completion(positions)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
