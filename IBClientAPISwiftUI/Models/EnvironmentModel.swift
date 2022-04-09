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
    @Published var tagSelection = 1
    @Published var accountViewModel: AccountViewModel
    
    init(accountViewModel: AccountViewModel?) {
        self.accountViewModel = accountViewModel ?? AccountViewModel(repository: nil)
    }
    
    
    func fetchData() {
        accountViewModel.fetchAccount()
    }
}
