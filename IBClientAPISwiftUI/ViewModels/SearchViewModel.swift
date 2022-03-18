//
//  SearchViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var tickets: [SearchTicket] = []
    
    private let repository: SearchRepositoryProtocol
    
    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }
        
    func searchForNameSymbol(value: String) {
        self.repository.searchForNameSymbol(value: value) { tickets in
            self.tickets = tickets
        }
    }
    
}
