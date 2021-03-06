//
//  AccountApiService_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 08.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class AccountApiService_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_AccountApiService_fetchAccount_shouldReturnItems() {
        let testAccount = MockedAccountModels.account
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: testAccount, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        accountApiService.fetchAccount { accounts in
            XCTAssertEqual(accounts.count, 1)
            XCTAssertEqual(accounts[0].accountId, testAccount[0].accountId)
        }

    }
    
    func test_AccountApiService_getAccountPerformance_shouldReturnItems() {
        let performanceResponse = MockedAccountModels.performanceResponse
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: performanceResponse, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        accountApiService.getAccountPerformance(accountIds: ["1"], freq: "Q") { (perfResponse, error) in
            XCTAssertEqual(perfResponse!.currencyType, performanceResponse.currencyType)
            XCTAssertEqual(perfResponse!.nav.data.description, performanceResponse.nav.data.description)
        }
    }
    
    func test_AccountApiService_getAccountAllocation_shouldReturnItems() {
        let testAllocationResponse = MockedAccountModels.allocationResponse
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: testAllocationResponse, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        accountApiService.getAccountAllocation(accountId: "account") { allocationResponse in
            XCTAssertEqual(allocationResponse.assetClass.short, testAllocationResponse.assetClass.short)
        }
    }

    func test_AccountApiService_getAccountSummary_shouldReturnItems() {
        let testAccountSummary = MockedAccountModels.accountSumary
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: testAccountSummary, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        
        accountApiService.getAccountSummary(accountId: "accountId") { accountSummary in
            XCTAssertEqual(accountSummary.count, testAccountSummary.count)
        }
    }
    
    func test_AccountApiService_getPnL_shouldReturnItems() {
        let pnlModelResponse = MockedAccountModels.pnlModelResponse
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: pnlModelResponse, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        accountApiService.getPnL { pnlResponse in
            XCTAssertEqual(pnlResponse.upnl.count, pnlModelResponse.upnl.count)
        }
    }
    
    func test_AccountApiService_getTickle_shouldReturnItems() {
        let tickleResponse = MockedAccountModels.tickleResponse
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: tickleResponse, paSummaryResponse: nil, iServerResponse: nil)
        
        accountApiService.tickle { tickle in
            XCTAssertEqual(tickle.session, tickleResponse.session)
        }
    }

    
    func test_AccountApiService_getCurrentBalance_shouldReturnItems() {
        let paSummary = MockedAccountModels.paSummaryResponse
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: paSummary, iServerResponse: nil)
        
        accountApiService.getCurrentBalance(acctIds: ["acctIds"]) { currBalance in
            XCTAssertEqual(currBalance.total?.startVal, paSummary.total?.startVal)
        }
    }
    
    func test_AccountApiService_iServerResponse_shouldReturnItems() {
        let iServerResponse = MockedAccountModels.iServerResponse
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: (iServerResponse, nil))
        
        accountApiService.getIServerAccount{ (response, error) in
            XCTAssertEqual(response?.accounts[0], iServerResponse.accounts[0])
        }
    }
    
    func test_AccountApiService_iServerResponse_shouldReturnUnathorizeError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.unauthorized)
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: iServerResponse)
        
        accountApiService.getIServerAccount{ (response, error) in
            XCTAssertTrue(response == nil)
            XCTAssertTrue(error != nil)
            XCTAssertEqual(error, NetworkError.unauthorized)
        }
    }
    
    func test_AccountApiService_iServerResponse_shouldReturnServerError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.serverError)
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: iServerResponse)
        
        accountApiService.getIServerAccount{ (response, error) in
            XCTAssertTrue(response == nil)
            XCTAssertTrue(error != nil)
            XCTAssertEqual(error, NetworkError.serverError)
        }
    }
    
    func test_AccountApiService_iServerResponse_shouldReturnDecodeError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.decodeError)
        
        let accountApiService: AccountApiServiceProtocol = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: iServerResponse)
        
        accountApiService.getIServerAccount{ (response, error) in
            XCTAssertTrue(response == nil)
            XCTAssertTrue(error != nil)
            XCTAssertEqual(error, NetworkError.decodeError)
        }
    }
}
