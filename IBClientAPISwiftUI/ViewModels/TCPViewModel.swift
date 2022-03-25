//
//  TCPViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 23.03.2022.
//

import Foundation


class TCPClass: NSObject {
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    var username = ""
    
    let maxReadLength = 4096
    
    func setupNetworkCommunication() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "localhost" as CFString, 5000, &readStream, &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream.delegate = self
        inputStream.schedule(in: .current, forMode: .common)
        outputStream.schedule(in: .current, forMode: .common)
        
        inputStream.open()
        outputStream.open()
    }
    
    func joinChat() {
      //1
      let data = "{\"session\": \"2cacae3e92ef526e1661da9aab7de293\"}".data(using: .utf8)!
      
      //2

      //3
      _ = data.withUnsafeBytes {
        guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
          print("Error joining chat")
          return
        }
        //4
        outputStream.write(pointer, maxLength: data.count)
      }
    }
    
}
