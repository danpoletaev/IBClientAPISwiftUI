//
//  DataManager.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 15.04.2022.
//

import Foundation

class CustomUrlSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

class DataManager: NSObject {
    let session: URLSession = URLSession(configuration: URLSessionConfiguration.default, delegate: CustomUrlSessionDelegate(), delegateQueue: OperationQueue.main)
    
    var API_URL: String
    
    override init () {
        let isHTTP: String = ProcessInfo.processInfo.environment["-UITest_isHTTP"] ?? "false"
        self.API_URL = isHTTP == "true" ? "http://\(APIConstants.COMMON_BASE_URL)/v1/api" : APIConstants.BASE_URL
        super.init()
    }
    
}
