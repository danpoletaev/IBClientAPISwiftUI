//
//  TransactionApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 22.03.2022.
//

import Foundation
import SwiftUI


final class TransactionApiService: DataManager, TransactionApiServiceProtocol {
    
    func placeOrder(order: Order, accountId: String, completion: @escaping ([PlaceOrderResponse]) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("/iserver/account/\(accountId)/orders")) else {
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
        
        request.httpBody = httpBody
        
        let task = self.session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let foundTickets = try JSONDecoder().decode([PlaceOrderResponse].self, from: data)
                DispatchQueue.main.async {
                    completion(foundTickets)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func confirmOrder(id: String, completion: @escaping (([ReplyItem]?, ReplyItemError?)) -> ()) {
        
        let apiUrl = GlobalEnivronment.shared.instanceURL.appending("/v1/api/")
        
        guard let url = URL(string: apiUrl.appending("iserver/reply/\(id)")) else {
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
        
        let task = self.session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                if let replyResponse = try? JSONDecoder().decode([ReplyItem]?.self, from: data) {
                    DispatchQueue.main.async {
                        completion((replyResponse, nil))
                    }
                    return;
                }
                
                if let placeOrderResponse = try? JSONDecoder().decode([PlaceOrderResponse]?.self, from: data) {
                    self.confirmOrder(id: placeOrderResponse[0].id) { (replyResponse, error) in
                        DispatchQueue.main.async {
                            completion((replyResponse, error))
                        }
                    }
                    return;
                }
                
                if let errorMessageResponse = try? JSONDecoder().decode(ReplyItemError?.self, from: data) {
                    completion((nil, errorMessageResponse))
                    return;
                } else {
                    completion((nil, ReplyItemError(error: "Unknown error")))
                    return;
                }
                
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
