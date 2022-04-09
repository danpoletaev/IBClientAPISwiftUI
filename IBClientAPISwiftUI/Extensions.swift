//
//  Extensions.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation
import UIKit


extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

enum WebSocketError: Error {
    case invalidFormat
}

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

extension URLSessionWebSocketTask.Message {
    func tickerInfo() throws -> TickerInfo {
        switch self {
        case .string:
            throw WebSocketError.invalidFormat
        case .data(let data):
            let tickerInfo = try JSONDecoder().decode(TickerInfo.self, from: data)
            return tickerInfo
        @unknown default:
            throw WebSocketError.invalidFormat
        }
    }
}


extension TickerInfo {
    func combine(newTicket: TickerInfo) -> TickerInfo {
        let high = newTicket.high ?? self.high
        let low = newTicket.low ?? self.low
        let marketValue = newTicket.marketValue ?? self.marketValue
        let avgPrice = newTicket.avgPrice ?? self.avgPrice
        let changeFromLastPrice = newTicket.changeFromLastPrice ?? self.changeFromLastPrice
        let changeFromLastPricePercentage = newTicket.changeFromLastPricePercentage ?? self.changeFromLastPricePercentage
        let unrPnL = newTicket.unrPnL ?? self.unrPnL
        let positions = newTicket.positions ?? self.positions
        let dailyPnL = newTicket.dailyPnL ?? self.dailyPnL
        let bid = newTicket.bid ?? self.bid
        let ask = newTicket.ask ?? self.ask
        let dayVolume = newTicket.dayVolume ?? self.dayVolume
        let requestId = newTicket.requestId ?? self.requestId
        let availability = newTicket.availability ?? self.availability
        let historyVolume = newTicket.historyVolume ?? self.historyVolume
        let avgDailyVolume = newTicket.avgDailyVolume ?? self.avgDailyVolume
        let marketCap = newTicket.marketCap ?? self.marketCap
        let pe = newTicket.pe ?? self.pe
        let eps = newTicket.eps ?? self.eps
        let costBasis = newTicket.costBasis ?? self.costBasis
        let weekHigh52 = newTicket.weekHigh52 ?? self.weekHigh52
        let weekLow52 = newTicket.weekLow52 ?? self.weekLow52
        let open = newTicket.open ?? self.open
        let close = newTicket.close ?? self.close
        let marketValuePercent = newTicket.marketValuePercent ?? self.marketValuePercent
        let conidEx = newTicket.conidEx ?? self.conidEx
        let dividend = newTicket.dividend ?? self.dividend
        let dividendYield = newTicket.dividendYield ?? self.dividendYield
        let conid = newTicket.conid ?? self.conid
        let updated = newTicket.updated ?? self.updated
        let serverID = newTicket.serverID ?? self.serverID
        let the87_Raw = newTicket.the87_Raw ?? self.the87_Raw
        let the78_Raw = newTicket.the78_Raw ?? self.the78_Raw
        let the7292_Raw = newTicket.the7292_Raw ?? self.the7292_Raw
        let the7282_Raw = newTicket.the7282_Raw ?? self.the7282_Raw
        
        return TickerInfo(high: high, low: low, marketValue: marketValue, avgPrice: avgPrice, changeFromLastPrice: changeFromLastPrice, changeFromLastPricePercentage: changeFromLastPricePercentage, unrPnL: unrPnL, positions: positions, dailyPnL: dailyPnL, bid: bid, ask: ask, dayVolume: dayVolume, requestId: requestId, availability: availability, historyVolume: historyVolume, avgDailyVolume: avgDailyVolume, marketCap: marketCap, pe: pe, eps: eps, costBasis: costBasis, weekHigh52: weekHigh52, weekLow52: weekLow52, open: open, close: close, marketValuePercent: marketValuePercent, conidEx: conidEx, dividend: dividend, dividendYield: dividendYield, conid: conid, updated: updated, serverID: serverID, the87_Raw: the87_Raw, the78_Raw: the78_Raw, the7292_Raw: the7292_Raw, the7282_Raw: the7282_Raw)
    }
}

extension Bundle {
    func decode<T: Codable>(type: T.Type, from file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("No file named: \(file) in Bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load")
        }
        
        let decoder = JSONDecoder()
        
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundel, missing file '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Type mismatch context \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(type) - context: \(context.debugDescription)")
        }  catch DecodingError.dataCorrupted(_) {
            fatalError("Wrong JSON")
        } catch {
            fatalError("Filed to decode \(file) from bundle")
        }
    }
}
