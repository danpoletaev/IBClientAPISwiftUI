//
//  MockTransactionModels.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 09.04.2022.
//

import Foundation


enum MockTransactionModels {
    static let placeOrderResponse: [PlaceOrderResponse] = Bundle.main.decode(type: [PlaceOrderResponse].self, from: "PlaceorderResponse.json")
    
    static let replyItemResponse: [ReplyItem] = Bundle.main.decode(type: [ReplyItem].self, from: "ReplyItemResponse.json")
}

