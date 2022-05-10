//
//  MainView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 09.05.2022.
//

import SwiftUI

let TAB_TITLES = [
    "Portfolio",
    "Interactive",
    "Account",
    "Orders"
]

struct MainView: View {
    
    @EnvironmentObject var environmentModel: EnvironmentViewModel
    @Environment(\.openURL) var openURL
    @State private var showingAuthorizationSheet = false
    
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let environmentModel = MockedAccountModels.mockedEvnironmentModel
        Group {
            MainView()
                .environmentObject(environmentModel)
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            
            MainView()
                .environmentObject(environmentModel)
                .environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        }
    }
}
