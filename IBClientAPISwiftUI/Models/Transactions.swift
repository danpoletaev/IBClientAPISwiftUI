//
//  Transactions.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 22.03.2022.
//

import Foundation
import SwiftUI


struct PlaceOrderResponse: Codable {
    var id: String
    var message: [String]
}


enum OrderTypes: String, Equatable, CaseIterable, Encodable {
    case LMT = "Limit"
    case MKT = "Market"
    case STP = "Stop"
    case STOP_LIMIT = "Stop Limit"
    case MIDPRICE = "MidPrice"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

enum SideTypes: String, Equatable, CaseIterable, Encodable {
    case SELL = "SELL"
    case BUY = "BUY"
}

enum TifTypes: String, Equatable, CaseIterable, Encodable {
    case GTC = "Good till cancel"
    case OPG = "OPG"
    case DAY = "DAY"
    case IOC = "IOC"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

struct Order: Encodable {
    var acctId: String?
    var conid: Int
    var secType: String
    var orderType: String
    var side: String
    var tif: String
    var quantity: Double
}

struct ReplyItem: Codable {
    var orderId: String?
    var order_status: String?
    var warning_message: String?
    var text: String?
    var encrypt_message: String?
}
