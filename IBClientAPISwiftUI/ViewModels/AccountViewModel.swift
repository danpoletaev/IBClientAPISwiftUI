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
    
    init(repository: AccountRepositoryProtocol = AccountRepository()) {
        self.repository = repository
    }
    
    func fetchAccount() {
        repository.fetchAccount { account in
            self.account = account
        }
        repository.getAccountBalances { summaryResponse in
            print(summaryResponse)
            self.total = summaryResponse.total
        }
    }
}

