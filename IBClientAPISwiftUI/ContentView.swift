//
//  ContentView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import AppTrackingTransparency


let coloredNavAppearance = UINavigationBarAppearance()

let TAB_TITLES = [
    "Portfolio",
    "Interactive",
    "Account",
    "Orders"
]

struct ContentView: View {
    @EnvironmentObject var environmentModel: EnvironmentViewModel
    @Environment(\.openURL) var openURL
    @State private var showingAuthorizationSheet = false
    @State private var showingSheet = false
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.gray
        UITabBar.appearance().backgroundColor = UIColor(CustomColor.darkBg)
        
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(CustomColor.lightBg)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
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
            .navigationBarTitle("Bar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationBar(title: TAB_TITLES[environmentModel.tagSelection])
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(Color.white)
        .onAppear(perform: {
            self.environmentModel.getIServerAccount{ (data, error) in
                if (error != nil) {
                    self.showingAuthorizationSheet = true
                }
            }
        })
        .onChange(of: showingAuthorizationSheet, perform: { newValue in
            print("auth \(newValue)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.environmentModel.getIServerAccount{ (data, error) in
                    if (error != nil) {
                        self.showingAuthorizationSheet = true
                    }
                }
            }
        })
        .sheet(isPresented: $showingAuthorizationSheet) {
            AuthorizationSheet()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let environmentModel = MockedAccountModels.mockedEvnironmentModel
        Group {
            ContentView()
                .environmentObject(environmentModel)
                .environment(\.colorScheme, .dark)
                .onAppear(perform: {
                    environmentModel.fetchData()
                })
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            ContentView()
                .environmentObject(environmentModel)
                .environment(\.colorScheme, .dark)
                .onAppear(perform: {
                    environmentModel.fetchData()
                })
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}
