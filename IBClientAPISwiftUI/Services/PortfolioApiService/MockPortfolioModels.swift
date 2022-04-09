//
//  MockedPortfolioModels.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import Foundation

enum MockPortfolioModels {
    static let positions: [Position] = Bundle.main.decode(type: [Position].self, from: "PortfolioPositions.json")
}
