//
//  SearchViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var tickets: [SearchTicket] = []
    
    @Published var isLoading = false
    
    private let repository: SearchRepositoryProtocol
    
    init(repository: SearchRepositoryProtocol?) {
        self.repository = repository ?? SearchRepository(apiService: nil)
    }
        
    func searchForNameSymbol(value: String) {
        self.isLoading = true
        self.repository.searchForNameSymbol(value: value) { tickets in
            self.tickets = tickets
            self.isLoading = false
        }
    }
}
