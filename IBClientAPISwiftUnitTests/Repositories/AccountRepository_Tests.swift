//
//  AccountRepository_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 10.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class AccountRepository_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_AccountRepository_init_shouldInitWithCorrectApiService() {
        let accountBalances = PASummaryResponse(rc: 1, view: "view", total: nil)
        
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: accountBalances, iServerResponse: nil)
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        accountRepository.getAccountBalances { accountBalancesResp in
            XCTAssertEqual(accountBalancesResp.rc, accountBalances.rc)
            XCTAssertEqual(accountBalancesResp.view, accountBalances.view)
        }
    }
    
    func test_AccountRepository_fetchAccount_shouldReturnAccountObject() {
        let mockedAccount = MockedAccountModels.account
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: mockedAccount, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        accountRepository.fetchAccount { account in
            XCTAssertEqual(account.accountId, mockedAccount[0].accountId)
            XCTAssertEqual(account.type, mockedAccount[0].type)
            XCTAssertEqual(account.accountTitle, mockedAccount[0].accountTitle)
            XCTAssertEqual(account.accountStatus, mockedAccount[0].accountStatus)
        }
    }
    
    func test_AccountRepository_getAccountBalances_shouldReturnFormattedAccountPerformance() {
        let mockedPerformance = MockedAccountModels.performanceResponse
        
        let mockedAccountPerformance = MockedAccountModels.mockedAccountPerformance
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: mockedPerformance, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        accountRepository.getAccountPerformance(accountIds: ["1"], freq: "Q") { (accountPerformance, error) in
            XCTAssertEqual(accountPerformance?.percentChange, mockedAccountPerformance.percentChange)
            XCTAssertEqual(accountPerformance?.dates.count, mockedAccountPerformance.dates.count)
            XCTAssertEqual(accountPerformance?.graphData.count, mockedAccountPerformance.graphData.count)
            XCTAssertEqual(accountPerformance?.graphData[0], mockedAccountPerformance.graphData[0])
            XCTAssertEqual(accountPerformance?.dates[0], mockedAccountPerformance.dates[0])
        }
    }
    
    func test_AccountRepository_getIServerAccount_shouldReturnAccountObject() {
        let mockedIServer = MockedAccountModels.iServerResponse
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: (mockedIServer, nil))
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        accountRepository.getIServerAccount { (response, error) in
            XCTAssertEqual(response?.accounts[0], mockedIServer.accounts[0])
            XCTAssertEqual(error, nil)
        }
    }

    func test_AccountRepository_getIServerAccount_shouldReturnUnathorizeError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.unauthorized)
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: iServerResponse)
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        accountRepository.getIServerAccount { (response, error) in
            XCTAssertTrue(response == nil)
            XCTAssertEqual(error, NetworkError.unauthorized)
        }
    }

    func test_AccountRepository_getIServerAccount_shouldReturnServerError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.serverError)
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: iServerResponse)
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        accountRepository.getIServerAccount { (response, error) in
            XCTAssertTrue(response == nil)
            XCTAssertEqual(error, NetworkError.serverError)
        }
    }

    func test_AccountRepository_getIServerAccount_shouldReturnDecodeError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.decodeError)
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: iServerResponse)
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        accountRepository.getIServerAccount { (response, error) in
            XCTAssertTrue(response == nil)
            XCTAssertEqual(error, NetworkError.decodeError)
        }
    }
}
