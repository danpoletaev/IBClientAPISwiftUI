//
//  MockTradesModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 09.04.2022.
//

import Foundation

enum MockTradesModels {
    static let allTradesResponse: AllTradesResponse = Bundle.main.decode(type: AllTradesResponse.self, from: "AllTradesResponse.json")
}
