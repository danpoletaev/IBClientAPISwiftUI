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
    @Published var authorized = false
    
    init(accountViewModel: AccountViewModel?) {
        self.accountViewModel = accountViewModel ?? AccountViewModel(repository: nil)
    }
    
    func getIServerAccount(completion: @escaping((Any?, NetworkError?)) -> ()) {
        self.accountViewModel.getIServerAccount { (data, error) in
            if error == NetworkError.unauthorized {
                self.authorized = false
            } else {
                self.authorized = true
            }
            print("authorization \(self.authorized)")
            completion((data, error))
        }
    }
    
    func fetchData() {
        accountViewModel.fetchAccount()
    }
}
