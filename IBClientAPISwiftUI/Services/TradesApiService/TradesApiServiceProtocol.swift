//
//  TradesApiServiceProtocol.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 17.04.2022.
//

import Foundation

protocol TradesApiServiceProtocol {
    func getAllTrades(completion: @escaping (AllTradesResponse) -> ())
}
