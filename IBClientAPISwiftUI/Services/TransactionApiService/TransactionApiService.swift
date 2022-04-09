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
    func confirmOrder(id: String, completion: @escaping ([ReplyItem]) -> ())
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
        
        var tempOrder = order
        tempOrder.acctId = accountId
        let bodyOrder = OrderData(orders: [tempOrder])
        
        
        guard let httpBody = try? JSONEncoder().encode(bodyOrder) else {
            print("Invalid httpBody")
            return
        }
        
        print(String(decoding: httpBody, as: UTF8.self))
        
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
    
    func confirmOrder(id: String, completion: @escaping ([ReplyItem]) -> ()) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("iserver/reply/\(id)")) else {
            print("Problem here")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        guard let httpBody = try? JSONEncoder().encode(ConfirmData(confirmed: true)) else {
            print("Invalid httpBody")
            return
        }
        
        
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                if let replyResponse = try JSONDecoder().decode([ReplyItem]?.self, from: data) {
                    DispatchQueue.main.async {
                        completion(replyResponse)
                    }
                }
                if let placeOrderResponse = try JSONDecoder().decode([PlaceOrderResponse]?.self, from: data) {
                    self.confirmOrder(id: placeOrderResponse[0].id) { replyResponse in
                        DispatchQueue.main.async {
                            completion(replyResponse)
                        }
                    }
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}

struct OrderData: Encodable {
    var orders: [Order]
}

struct ConfirmData: Encodable {
    var confirmed: Bool
}
