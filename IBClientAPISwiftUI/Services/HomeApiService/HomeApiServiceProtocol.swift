//
//  HomeApiServiceProtocol.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 17.04.2022.
//

import Foundation

protocol HomeApiServiceProtocol {
    func getScannerConids(completion: @escaping ((ScannerResponse?, NetworkError?)) -> Void)
}
