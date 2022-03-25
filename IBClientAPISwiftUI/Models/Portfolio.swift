//
//  Portfolio.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

// Portfolio
struct Position: Codable {
    let acctID: String?
    let conid: Int
    let contractDesc: String?
    let position, mktPrice, mktValue: Double?
    let currency: String?
    let avgCost, avgPrice: Double?
    let realizedPnl: Double?
    let unrealizedPnl: Double?
    let exchs, expiry, putOrCall: Double?
    let multiplier: Int?
    let exerciseStyle: String?
    let conExchMap: [String]
    let assetClass: String?
    let undConid: Int?
    let model: String?
    let time: Int?
    let chineseName: String?
    let allExchanges, listingExchange, countryCode: String?
    let name: String?
    let lastTradingDay: String?
    let group, sector, sectorGroup, ticker: String?
    let type: String?
    let hasOptions: Bool?
    let fullName: String?
    let isUS: Bool?
    let incrementRules: [IncrementRule]?
    let displayRule: DisplayRule?
    let pageSize: Int?
    var priceChange: String?
}

// MARK: - DisplayRule
struct DisplayRule: Codable {
    let magnification: Int
    let displayRuleStep: [DisplayRuleStep]
}

// MARK: - DisplayRuleStep
struct DisplayRuleStep: Codable {
    let decimalDigits, lowerEdge, wholeDigits: Int
}

// MARK: - IncrementRule
struct IncrementRule: Codable {
    let lowerEdge: Int
    let increment: Double
}
