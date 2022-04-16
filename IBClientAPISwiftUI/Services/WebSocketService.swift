//
//  WebSocketService.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 24.03.2022.
//

import Foundation


class WebSocketService: AsyncSequence {
    
    typealias Element = URLSessionWebSocketTask.Message
    typealias AsyncIterator = AsyncThrowingStream<URLSessionWebSocketTask.Message, Error>.Iterator
    
    private var stream: AsyncThrowingStream<Element, Error>?
    private var continuation: AsyncThrowingStream<Element, Error>.Continuation?
    private let socket: URLSessionWebSocketTask
    
    let session: URLSession = URLSession(configuration: URLSessionConfiguration.default, delegate: CustomUrlSessionDelegate(), delegateQueue: OperationQueue.main)
    
    init(url: String, session: URLSession = URLSession(configuration: URLSessionConfiguration.default, delegate: CustomUrlSessionDelegate(), delegateQueue: OperationQueue.main)) {
        socket = session.webSocketTask(with: URL(string: url)!)
        stream = AsyncThrowingStream { continuation in
            self.continuation = continuation
            self.continuation?.onTermination = { @Sendable [socket] _ in
                socket.cancel()
            }
        }
    }
    
    func makeAsyncIterator() -> AsyncIterator {
        guard let stream = stream else {
            fatalError("strem was not initialized")
        }
        socket.resume()
        listenForMessages()
        return stream.makeAsyncIterator()
    }
    
    private func listenForMessages() {
        socket.receive { [unowned self] result in
            switch result {
            case .success(let message):
                continuation?.yield(message)
                listenForMessages()
            case .failure(let error):
                continuation?.finish(throwing: error)
            }
        }
    }
    
    func ping() {
        socket.sendPing { error in
            if let error = error {
                print("Ping error: \(error)")
            }
        }
    }
    
    func authorize(token: String) {
        send(message: token)
    }
    
    func sendRepeatedly(message: String) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [self] in
            send(message: message)
        }
    }
    
    func send(message: String) {
        let encodedMessage = URLSessionWebSocketTask.Message.string(message)
        socket.send(encodedMessage) { error in
            if let error = error {
                print("Send error \(error)")
            }
        }
    }
    
    func close() {
        socket.cancel(with: .goingAway, reason: "Navigate away".data(using: .utf8))
    }
}

