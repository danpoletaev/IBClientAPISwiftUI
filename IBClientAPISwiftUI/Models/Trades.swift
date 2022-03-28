//
//  Trades.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 28.03.2022.
//

import Foundation

struct AllTradesResponse: Decodable {
    var orders: [TickerOrderItem]
}

struct TickerOrderItem: Decodable {
    var acct: String
    var conidex: String
    var conid: Double
    var orderId: Double
    var cashCcy: String
    var sizeAndFills: String
    var orderDesc: String
    var description1: String
    var ticker: String
    var secType: String
    var listingExchange: String
    var remainingQuantity: Double
    var filledQuantity: Double
    var companyName: String
    var status: String
    var origOrderType: String
    var supportsTaxOpt: String
    var lastExecutionTime: String
    var orderType: String
    var side: String
    var avgPrice: String?
    var lastExecutionTime_r: Double
}
