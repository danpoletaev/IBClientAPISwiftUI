//
//  MockSearchApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 09.04.2022.
//

import Foundation


class MockSearchApiService: SearchApiServiceProtocol {
    
    let searchTicket: [SearchTicket]
    
    init(searchTicket: [SearchTicket]?) {
        self.searchTicket = searchTicket ?? MockSeachModels.searchTickets
    }
    
    func searchForNameSymbol(value: String, completion: @escaping ([SearchTicket]) -> ()) {
            completion(searchTicket)
    }
    
}
