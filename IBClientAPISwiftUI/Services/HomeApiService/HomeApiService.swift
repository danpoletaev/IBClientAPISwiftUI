//
//  HomeApiService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class HomeApiService: DataManager, HomeApiServiceProtocol {
    func getScannerConids(completion: @escaping ((ScannerResponse?, NetworkError?)) -> Void) {
        guard let url = URL(string: self.API_URL.appending("/hmds/scanner")) else {
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
        
        let task = self.session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode >= 400) {
                        self.getScannerConids { (response, error) in
                            completion((response, error))
                        }
                        return
                    }
                }
            
            do {
                let scannerResponse = try JSONDecoder().decode(ScannerResponse.self, from: data)
                DispatchQueue.main.async {
                    completion((scannerResponse, nil))
                }
            } catch {
                completion((nil, NetworkError.decodeError))
            }
        }
        task.resume()
    }
}
