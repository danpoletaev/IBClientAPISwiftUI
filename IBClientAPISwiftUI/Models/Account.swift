//
//  Account.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

struct Account: Codable, Identifiable {
    let id: String
    let accountId: String
    let accountVan: String
    let accountTitle: String
    let displayName: String
    let accountAlias: String?
    let accountStatus: Decimal
    let currency: String
    let type: String
    let tradingType: String
    let ibEntity: String
    let faclient: Bool
    let clearingStatus: String
    let covestor: Bool
    let parent: AccountParent
    let desc: String
}

struct AccountParent: Codable {
    let mmc: [String]
    let accountId: String
    let isMParent: Bool
    let isMChild: Bool
    let isMultiplex: Bool
}

struct AccountPerformance {
    let graphData: [Double]
    let dates: [String]
}


// MARK: - WelcomeValue
struct AccountSummaryItem: Codable {
    let amount: Double
    let currency: Currency?
    let isNull: Bool
    let timestamp: Int
    let value: String?
    let severity: Int
}

enum Currency: String, Codable {
    case czk = "CZK"
}

typealias AccountSummary = [String: AccountSummaryItem]


struct AllocationResponse: Codable {
    let assetClass: AssetClass
}

struct AssetClass: Codable {
    let long: [String: Double]
    let short: [String: Double]
}

struct PnLModelResponseModel: Codable {
    let upnl: PnLModel
}

typealias PnLModel = [String: CorePnLModel]

struct  CorePnLModel: Codable {
    let rowType: Int?
    let dpl: Double?
    let nl: Double?
    let upl: Double?
    let el: Double?
    let mv: Double?
}


struct PerformanceResponse: Codable {
    let currencyType: String
    let nav: Nav
}

struct Nav: Codable {
    let data: [NavDataItem]
    let freq: String
    let dates: [String]
}

struct NavDataItem: Codable {
    let idType: String
    let start: String
    let navs: [Double]
    let end: String
    let id: String
    let startNAV: StartNav
}

struct StartNav: Codable {
    let date: String
    let val: Double
}


struct PerformancePostData: Encodable {
    let acctIds: [String]
    let freq: String
}
