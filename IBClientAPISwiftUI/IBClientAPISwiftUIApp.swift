//
//  IBClientAPISwiftUIApp.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import SwiftUI

@main
struct IBClientAPISwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            let environmentModel = EnvironmentViewModel(accountViewModel: AccountViewModel(repository: nil))
            
            ContentView().environmentObject(environmentModel)
                .onAppear(perform: {
                    environmentModel.fetchData()
                })
                .environment(\.colorScheme, .dark)
        }
    }
}
