//
//  HomeApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

protocol HomeApiServiceProtocol {
    func getScannerConids(completion: @escaping (ScannerResponse) -> Void)
}

final class HomeApiService: HomeApiServiceProtocol {
    func getScannerConids(completion: @escaping (ScannerResponse) -> Void) {
        guard let url = URL(string: APIConstants.BASE_URL.appending("/hmds/scanner")) else {
            print("Problem here")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let searchData = ScannerPostData(instrument: "STK", secType: "STK", locations: "STK.US.MAJOR", scanCode: "TOP_PERC_GAIN")
        
        guard let httpBody = try? JSONEncoder().encode(searchData) else {
            print("Invalid httpBody")
            return
        }
        
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let scannerResponse = try JSONDecoder().decode(ScannerResponse.self, from: data)
                DispatchQueue.main.async {
                    print("decoded successfully")
                    completion(scannerResponse)
                }
            } catch {
                print("here problem")
                print(error)
            }
        }
        task.resume()
    }
}
