//
//  SearchApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class SearchApiService: DataManager, SearchApiServiceProtocol {
    
    func searchForNameSymbol(value: String, completion: @escaping ([SearchTicket]) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/iserver/secdef/search")) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let searchData = SearchPostData(symbol: value, name: true)
        
        guard let httpBody = try? JSONEncoder().encode(searchData) else {
            print("Invalid httpBody")
            return
        }
        
        request.httpBody = httpBody
        
        let task = self.session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let foundTickets = try JSONDecoder().decode([SearchTicket].self, from: data)
                DispatchQueue.main.async {
                    completion(foundTickets)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
