//
//  EnvironmentModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

class EnvironmentViewModel: ObservableObject {
    
    @Published var tagSelection = 1
    @Published var accountViewModel: AccountViewModel
    @Published var authorized = false
    @Published var instanceURL: String = ""
    
    init(accountViewModel: AccountViewModel?) {
        self.accountViewModel = accountViewModel ?? AccountViewModel(repository: nil)
    }
    
    func getIServerAccount(completion: @escaping((IServerResponse?, NetworkError?)) -> ()) {
        self.accountViewModel.getIServerAccount { (data, error) in
            if error != nil{
                DispatchQueue.main.async {
                    self.authorized = false
                }
            } else {
                DispatchQueue.main.async {
                    self.authorized = true
                }
            }
            completion((data, error))
        }
    }
    
    func fetchData() {
        accountViewModel.fetchAccount()
    }
}
