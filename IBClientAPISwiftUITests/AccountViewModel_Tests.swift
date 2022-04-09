//
//  AccountViewModel.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 08.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedNehavior

// Testring Structure: Given, When, Then

class AccountViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_AccountViewModel_fetchAccount_AccountShouldBeFetched() {
        // Given
        let testableAccount = Account(id: "1", accountId: "1", accountVan: "Account Van", accountTitle: "First Name", displayName: "Display Name", accountAlias: "UA", accountStatus: 123123.12, currency: "CZK", type: "INDIVIDUAL", tradingType: "STKCASH", ibEntity: "IB-CE", faclient: false, clearingStatus: "0", covestor: false, parent: AccountParent(mmc: [], accountId: "", isMParent: false, isMChild: false, isMultiplex: false), desc: "Description")
        
        let viewModel = AccountViewModel(
            repository: AccountRepository(
                apiService: MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil)
            )
        )
        
        // When
        
        // Then
    }

}
