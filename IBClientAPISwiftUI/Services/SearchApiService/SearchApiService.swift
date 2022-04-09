//
//  SearchApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol SearchApiServiceProtocol {
    func searchForNameSymbol(value: String, completion: @escaping ([SearchTicket]) -> ())
}


final class SearchApiService: SearchApiServiceProtocol {
    
    func searchForNameSymbol(value: String, completion: @escaping ([SearchTicket]) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/iserver/secdef/search")) else {
            print("Problem here")
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
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let foundTickets = try JSONDecoder().decode([SearchTicket].self, from: data)
                DispatchQueue.main.async {
                    print("decoded successfully")
                    completion(foundTickets)
                }
            } catch {
                print("here problem")
                print(error)
            }
        }
        task.resume()
    }
    
}
