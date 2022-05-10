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
}
