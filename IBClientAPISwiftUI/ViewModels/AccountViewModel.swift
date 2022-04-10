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
        self.repository = repository ?? AccountRepository(apiService: AccountApiService())
    }
    
    func getIServerAccount(completion: @escaping((Any?, NetworkError?)) -> ()) {
        repository.getIServerAccount { response in
            completion(response)
            
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

