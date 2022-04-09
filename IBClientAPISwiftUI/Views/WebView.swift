//
//  WebView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 06.04.2022.
//

import Foundation
import SwiftUI
import WebKit

//class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        // TODO
//        decisionHandler(.allow)
//    }
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        // TODO
//        decisionHandler(.allow)
//    }
//
//    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//        completionHandler(.useCredential, cred)
//    }
//}
//
//struct WebView: UIViewRepresentable {
//
//    let url: URL
//
//    func getAuthenticatedURL(from url: URL) -> URL? {
//        let session = URLSession.shared
//        let semaphore = DispatchSemaphore(value:0)
//
//        var result: URL? = nil
//
//        session.configuration.httpCookieAcceptPolicy = .always
//
//        session.dataTask(with: url) { data, response, _ in
//            //            print(data)
//            result = response?.url
//            semaphore.signal()
//        }.resume()
//
//
//        semaphore.wait()
//
//        return result
//    }
//
//
//    //    "XYZAB_AM.LOGIN=\"\"; Domain=.api.ibkr.com; Path=/;Secure;SameSite=None",
//    //    "XYZAB=\"\"; Domain=.api.ibkr.com; Path=/;Secure;SameSite=None",
//    //    "URL_PARAM=\"forwardTo=22&RL=1&ip2loc=US\"; Version=1; Domain=.api.ibkr.com; Path=/;Secure;HttpOnly",
//    //    "JSESSIONID=6D040EA82861F5B6D17DD15F65C99A81.ny5wwwdam2-internet; Path=/sso; HttpOnly;Secure;SameSite=None"
//
//    func makeUIView(context: Context) -> WKWebView {
//
//        //        guard let cookie = HTTPCookie(properties: [
//        //               .domain: ".api.ibkr.com",
//        //               .path: "/",
//        //               .name: "ath_access_token",
//        //               .value: "accessToken",
//        //               .secure: "true",
//        //               .expires: NSDate(timeIntervalSinceNow: now() + 360000)
//        //           ]) else { return }
//
//        //        let conf = WKWebViewConfiguration()
//        //        let ctrl = WKUserContentController()
//        //
//        //        conf.userContentController = ctrl
//        //
//        //        let wkDataStore = WKWebsiteDataStore.nonPersistent()
//        //
//        //        wkDataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), modifiedSince: .distantPast) { }
//        //
//        //        HTTPCookieStorage.shared.cookies?.forEach{wkDataStore.httpCookieStore.setCookie($0)}
//        //        HTTPCookieStorage.shared.cookies?.forEach{print($0)}
//        //
//        //        conf.websiteDataStore = wkDataStore
//        //
//        //        let webView = WKWebView(frame: .zero, configuration: conf)
//        //
//        //        let authenticatedURL = getAuthenticatedURL(from: url)
//        //
//        //        HTTPCookieStorage.shared.cookies(for: url)
//
//        let configuration = WKWebViewConfiguration()
//        configuration.websiteDataStore = .nonPersistent()
//        let webView = WKWebView(frame: .zero, configuration: configuration)
//        let navigationDelegate = WebViewNavigationDelegate()
//        webView.navigationDelegate = navigationDelegate
//
//        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
//        webView.load(request)
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
//        uiView.load(request)
//    }
//}



struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // TODO
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        // TODO
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("credentials")
        let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, cred)
    }
    
}

class WebViewModel: ObservableObject {
    let webView: WKWebView
    
    private let navigationDelegate: WebViewNavigationDelegate
    
    init() {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .nonPersistent()
        webView = WKWebView(frame: .zero, configuration: configuration)
        navigationDelegate = WebViewNavigationDelegate()
        
        webView.navigationDelegate = navigationDelegate
        setupBindings()
    }
    
    @Published var urlString: String = "https://\(APIConstants.COMMON_BASE_URL)"
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var isLoading: Bool = false
    
    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        
        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
        
        webView.publisher(for: \.isLoading)
            .assign(to: &$isLoading)
        
    }
    
    func loadUrl() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }
}
