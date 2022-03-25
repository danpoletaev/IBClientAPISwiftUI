//
//  TransactionApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 22.03.2022.
//

import Foundation
import SwiftUI

protocol TransactionApiServiceProtocol {
    func placeOrder(order: Order, accountId: String, completion: @escaping ([PlaceOrderResponse]) -> ())
}


final class TransactionApiService: TransactionApiServiceProtocol {
    
    func placeOrder(order: Order, accountId: String, completion: @escaping ([PlaceOrderResponse]) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/iserver/account/\(accountId)/orders")) else {
            print("Problem here")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONEncoder().encode(order) else {
            print("Invalid httpBody")
            return
        }
        
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let foundTickets = try JSONDecoder().decode([PlaceOrderResponse].self, from: data)
                DispatchQueue.main.async {
                    print("decoded successfully")
                    completion(foundTickets)
                }
            } catch {
                print("here problem")
                print(error)
            }
        }
        task.resume()
    }
}

struct PlaceOrderResponse: Decodable {
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
    var conid: Int
    var conidex: String?
    var secType: String
    var cOID: String
    var parentId: String?
    var orderType: String // OrderTypes
    var listingExchange: String?
    var isSingleGroup: Bool
    var outsideRTH: Bool
    var price: Double? // limit price
    var auxPrice: Double? // stop price both price and auxPrice for STOP_LIMIT orders
    var side: String // SideTypes
    var ticker: String
    var tif: String // TifTypes
    var referrer: String?
    var quantity: Double?
    var cashQty: Double?
    var fxQty: Double?
    var useAdaptive: Bool // Price Managment Algo
    var isCcyConv: Bool // Order is a FX conversion order
    var allocationMethod: String?
    var strategy: String?
    var strategyParameters: String?
    
}


