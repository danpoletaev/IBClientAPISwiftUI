//
//  MockedHomeModels.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import Foundation

enum MockedHomeModels {
    static let scannerResponse: ScannerResponse = Bundle.main.decode(type: ScannerResponse.self, from: "ScannerResponse.json")
}
