//
//  Home.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

struct ScannerResponse: Codable {
    let Contracts: Contracts
}

struct Contracts: Codable {
    let Contract: [ContractItem]
}

struct ContractItem: Codable {
    let inScanTime: String
    let contractID: String
}


struct ScannerPostData: Encodable {
    var instrument: String
    let secType: String
    let locations: String
    let scanCode: String
}
