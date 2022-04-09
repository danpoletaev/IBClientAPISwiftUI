//
//  ContentView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import AppTrackingTransparency

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var model = WebViewModel()
    
    var body: some View {
        WebView(webView: model.webView)
    }
}


struct ContentView: View {
    @EnvironmentObject var environmentModel: EnvironmentModel
    @Environment(\.openURL) var openURL
    
    
    @State private var showingSheet = false
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.gray
        UITabBar.appearance().backgroundColor = UIColor(CustomColor.darkBg)
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $environmentModel.tagSelection) {
                PortfolioView(portfolioViewModel: nil)
                    .background(CustomColor.lightBg)
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle")
                        
                        Text("Portfolio")
                    }
                    .tag(0)
                
                HomeView(homeViewModel: nil)
                    .background(CustomColor.lightBg)
                    .tabItem{
                        Image(systemName: "house.fill")
                        
                        Text("Home")
                    }
                    .tag(1)
                
                
                AccountView()
                    .background(CustomColor.lightBg)
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        
                        Text("Account")
                    }
                    .tag(2)
                
                TradesView(tradesViewModel: nil)
                    .background(CustomColor.lightBg)
                    .tabItem {
                        Image(systemName: "chart.bar.doc.horizontal.fill")
                        
                        Text("Orders")
                    }
                    .tag(3)
            }
            .navigationTitle("Bar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationBar(title: "Interactive")
            }
        }.accentColor(Color.white)
//            .onAppear(perform: {
////                openURL(URL(string: "http://\(APIConstants.COMMON_BASE_URL)")!)
//                //Ask for notification permission
////                let n = NotificationHandler()
////                n.askNotificationPermission {
////                    //n.scheduleAllNotifications()
////
////                    //IMPORTANT: wait for 1 second to display another alert
////                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
////                        if #available(iOS 14, *) {
////                          ATTrackingManager.requestTrackingAuthorization { (status) in
////                              self.showingSheet = true
////                            //print("IDFA STATUS: \(status.rawValue)")
////                            //FBAdSettings.setAdvertiserTrackingEnabled(true)
////                          }
////                        }
////                    }
////                }
//            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
