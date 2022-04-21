//
//  PortfolioApiServiceProtocol.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 17.04.2022.
//

import Foundation

protocol PortfolioApiServiceProtocol {
    func fetchPositions(accountID: String, completion: @escaping ([Position]) -> Void)
}
