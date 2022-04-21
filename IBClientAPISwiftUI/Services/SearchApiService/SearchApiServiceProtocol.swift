//
//  SearchApiServiceProtocol.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 17.04.2022.
//

import Foundation

protocol SearchApiServiceProtocol {
    func searchForNameSymbol(value: String, completion: @escaping ([SearchTicket]) -> ())
}
