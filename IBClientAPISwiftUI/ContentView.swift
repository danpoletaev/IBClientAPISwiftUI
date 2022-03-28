//
//  ContentView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var environmentModel: EnvironmentModel
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.gray
        UITabBar.appearance().backgroundColor = UIColor(CustomColor.darkBg)
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $environmentModel.tagSelection) {
                PortfolioView()
                    .background(CustomColor.lightBg)
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle")
                        
                        Text("Portfolio")
                    }
                    .tag(0)
                
                HomeView()
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
                
                TradesView()
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
