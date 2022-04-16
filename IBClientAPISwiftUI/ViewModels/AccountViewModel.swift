//
//  AccountViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class AccountViewModel: ObservableObject {
    @Published var account: Account? = nil
    @Published var total: AccountTotal? = nil
    
    private let repository: AccountRepositoryProtocol
    
    init(repository: AccountRepositoryProtocol?) {
        self.repository = repository ?? AccountRepository(apiService: nil)
    }
    
    func getIServerAccount(completion: @escaping((IServerResponse?, NetworkError?)) -> ()) {
        repository.getIServerAccount { (response, error) in
            completion((response, error))
            
        }
    }
    
    func fetchAccount() {
        repository.fetchAccount { account in
            self.account = account
        }
        
        repository.getAccountBalances { summaryResponse in
            self.total = summaryResponse.total
        }
    }
}

