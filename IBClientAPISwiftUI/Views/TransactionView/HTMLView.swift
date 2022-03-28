//
//  HTMLView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 27.03.2022.
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    
    let htmlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}
