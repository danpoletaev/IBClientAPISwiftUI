//
//  TransactionApiServiceProtocol.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 17.04.2022.
//

import Foundation

protocol TransactionApiServiceProtocol {
    func placeOrder(order: Order, accountId: String, completion: @escaping ([PlaceOrderResponse]) -> ())
    func confirmOrder(id: String, completion: @escaping ([ReplyItem]) -> ())
}
