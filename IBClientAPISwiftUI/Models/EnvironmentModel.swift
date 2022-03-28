//
//  EnvironmentModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

class EnvironmentModel: ObservableObject {

    @Published var positions: [Position] = []
    @Published var topPositions: [Position] = []
    @Published var accountViewModel = AccountViewModel()
    @Published var tagSelection = 1
    
    
    func fetchData() {
        
        accountViewModel.fetchAccount()
        
    }
}
