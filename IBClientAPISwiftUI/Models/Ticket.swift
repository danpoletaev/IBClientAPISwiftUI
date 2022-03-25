//
//  Ticket.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

struct TickerInfo: Codable {
    var high, low, marketValue, avgPrice: String?
    var changeFromLastPrice: String?
    var changeFromLastPricePercentage: Double?
    var unrPnL, positions, dailyPnL, bid: String?
    var ask, dayVolume, requestId, availability: String?
    var historyVolume, avgDailyVolume, marketCap, pe: String?
    var eps, costBasis, weekHigh52, weekLow52: String?
    var open, close, marketValuePercent, conidEx: String?
    var dividend, dividendYield: String?
    var conid: Double
    var updated: Double?
    var serverID: String?
    var the87_Raw, the78_Raw: Double?
    var the7292_Raw: Double?
    var the7282_Raw: Double?
    
    enum CodingKeys: String, CodingKey {
        case high = "70"
        case low = "71"
        case marketValue = "73"
        case avgPrice = "74"
        case unrPnL = "75"
        case positions = "76"
        case dailyPnL = "78"
        case changeFromLastPrice = "82"
        case changeFromLastPricePercentage = "83"
        case bid = "84"
        case ask = "86"
        case dayVolume = "87"
        case requestId = "6119"
        case availability = "6509"
        case historyVolume = "7087"
        case avgDailyVolume = "7282"
        case dividend = "7286"
        case dividendYield = "7287"
        case marketCap = "7289"
        case pe = "7290"
        case eps = "7291"
        case costBasis = "7292"
        case weekHigh52 = "7293"
        case weekLow52 = "7294"
        case open = "7295"
        case close = "7296" //todo
        case marketValuePercent = "7639" // maybe real pnl
        case conidEx, conid
        case updated = "_updated"
        case serverID = "server_id"
        case the87_Raw = "87_raw"
        case the78_Raw = "78_raw"
        case the7292_Raw = "7292_raw"
        case the7282_Raw = "7282_raw"
    }
}


struct HistoryConidResponse: Codable {
    let timePeriod: String
    let data: [OneBarData]
}

struct OneBarData: Codable {
    let o: Double
    let c: Double
    let h: Double
    let l: Double
    let v: Double
    let t: Double
}


struct SecDefResponse: Codable {
    let secdef: [SecDefConid]
}

struct SecDefConid: Codable {
    let conid: Int
    let currency: String?
    let listingExchange: String?
    let name: String?
    let assetClass: String?
    let ticker: String?
    let lastPrice: String?
    let percentChange: Double?
}

struct SecDefPostData: Encodable {
    let conids: [Int]
}
