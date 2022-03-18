//
//  Search.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

struct SearchTicket: Codable {
    let conid: Double
    let companyHeader: String?
    let companyName: String?
    let symbol: String?
    let description: String?
    let restricted: String?
}


struct SearchPostData: Encodable {
    var symbol: String = ""
    var name: Bool = false
}
