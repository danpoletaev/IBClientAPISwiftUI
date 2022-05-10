//
//  ContentView.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI
import AppTrackingTransparency


let coloredNavAppearance = UINavigationBarAppearance()

struct ContentView: View {
    @EnvironmentObject var environmentModel: EnvironmentViewModel
    @Environment(\.openURL) var openURL
    @State private var showingAuthorizationSheet = false
    @StateObject var globalEnvironment = GlobalEnivronment.shared
    
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
        if globalEnvironment.instanceURL.isEmpty {
            InstanceView()
        } else {
            MainView()
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
