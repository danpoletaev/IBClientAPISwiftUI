//
//  APIConstants.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

enum APIConstants {
    static let CONID_FIELDS = "70,71,73,74,75,76,78,82,83,84,86,87,7087,7282,7286,7287,7289,7290,7291,7292,7293,7294,7295,7296,7633,7639"
    static let STRING_FIELDS = "[\"70\",\"71\",\"73\",\"74\",\"75\",\"76\",\"78\",\"82\",\"83\",\"84\",\"86\",\"87\",\"7087\",\"7287\",\"7286\",\"7287\",\"7289\",\"7290\",\"7291\",\"7292\",\"7293\",\"7294\",\"7295\",\"7296\",\"7633\",\"7639\"]"
}



enum NetworkError: Error {
    case unauthorized
    case serverError
    case decodeError
}
