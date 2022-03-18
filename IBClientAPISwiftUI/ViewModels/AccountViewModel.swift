//
//  AccountViewModel.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 18.03.2022.
//

import Foundation

final class AccountViewModel: ObservableObject {
    @Published var account: Account? = nil
    
    private let repository: AccountRepositoryProtocol
    
    init(repository: AccountRepositoryProtocol = AccountRepository()) {
        self.repository = repository
    }
    
    func fetchAccount() {
        repository.fetchAccount { account in
            self.account = account
        }
    }
}

