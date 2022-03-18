//
//  SearchRepository.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol SearchRepositoryProtocol {
    func searchForNameSymbol(value: String, completion: @escaping ([SearchTicket]) -> ())
}

final class SearchRepository: SearchRepositoryProtocol {
    
    private let apiService: SearchApiServiceProtocol
    
    init(apiService: SearchApiServiceProtocol = SearchApiService()) {
        self.apiService = apiService
    }
    
    func searchForNameSymbol(value: String, completion: @escaping ([SearchTicket]) -> ()) {
        self.apiService.searchForNameSymbol(value: value) { tickers in
            completion(tickers)
        }
    }
    
}
