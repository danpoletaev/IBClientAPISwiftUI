//
//  MockHomeApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 08.04.2022.
//

import Foundation

class MockHomeApiService: HomeApiServiceProtocol {
    let scannerResponse: ScannerResponse
    
    init(scannerResponse: ScannerResponse?) {
        self.scannerResponse = scannerResponse ?? MockedHomeModels.scannerResponse
    }
    
    func getScannerConids(completion: @escaping ((ScannerResponse?, NetworkError?)) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion((self.scannerResponse, nil))
        }
    }
}
