//
//  TickerApiServiceProtocol.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 17.04.2022.
//

import Foundation

protocol TickerApiServiceProtocol {
    func getTickerInfo(conid: Int, completion: @escaping ([TickerInfo]) -> Void)
    func getSecDefByConids(value: [Int], completion: @escaping (SecDefResponse) -> Void)
    func getConidHistory(conid: Int, period: String, completion: @escaping (HistoryConidResponse) -> ())
}
