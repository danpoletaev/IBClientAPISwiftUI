//
//  MockedPortfolioApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import Foundation

class MockPortfolioApiService: PortfolioApiServiceProtocol {
    
    let positions: [Position]
    
    init(positions: [Position]?) {
        self.positions = positions ?? MockPortfolioModels.positions
    }
    
    func fetchPositions(accountID: String, completion: @escaping ([Position]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.positions)
        }
    }
    
}
