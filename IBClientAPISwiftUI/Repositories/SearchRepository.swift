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
    
    init(apiService: SearchApiServiceProtocol?) {
        let shouldUseMockedService: String = ProcessInfo.processInfo.environment["-UITest_mockService"] ?? "false"
        if shouldUseMockedService == "true" {
            self.apiService = MockSearchApiService(searchTicket: nil)
        } else {
            self.apiService = apiService ?? SearchApiService()
        }
    }
    
    func searchForNameSymbol(value: String, completion: @escaping ([SearchTicket]) -> ()) {
        self.apiService.searchForNameSymbol(value: value) { tickers in
            completion(tickers)
        }
    }
    
}
