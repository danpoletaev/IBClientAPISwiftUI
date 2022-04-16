//
//  AccountViewModel_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 12.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI
import Combine

class AccountViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_AccountViewModel_getIServerAccount_shouldReturnIServerResponse() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (MockedAccountModels.iServerResponse, nil)
        
        let accountApiService =  MockAccountApiService(accountTestData: nil,
                                                       accountPerformanceTestData: nil,
                                                       allocationTestResponse: nil,
                                                       accountSummaryTest: nil,
                                                       pnlModelResponseTest: nil,
                                                       testTickleResponse: nil,
                                                       paSummaryResponse: nil,
                                                       iServerResponse: iServerResponse
        )
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        let accountViewModel = AccountViewModel(repository: accountRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: (IServerResponse?, NetworkError?) = (nil, nil)
        
        accountViewModel.getIServerAccount { response in
            result = response
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result.0 != nil)
        XCTAssertEqual(result.0?.accounts, iServerResponse.0?.accounts)
    }
    
    func test_AccountViewModel_getIServerAccount_shouldReturnUnauthorizeError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.unauthorized)
        
        let accountApiService =  MockAccountApiService(accountTestData: nil,
                                                       accountPerformanceTestData: nil,
                                                       allocationTestResponse: nil,
                                                       accountSummaryTest: nil,
                                                       pnlModelResponseTest: nil,
                                                       testTickleResponse: nil,
                                                       paSummaryResponse: nil,
                                                       iServerResponse: iServerResponse
        )
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        let accountViewModel = AccountViewModel(repository: accountRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: (IServerResponse?, NetworkError?) = (nil, nil)
        
        accountViewModel.getIServerAccount { response in
            result = response
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result.0 == nil)
        XCTAssertTrue(result.1 != nil)
        XCTAssertEqual(result.1, NetworkError.unauthorized)
    }
    
    func test_AccountViewModel_getIServerAccount_shouldReturnServerError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.serverError)
        
        let accountApiService =  MockAccountApiService(accountTestData: nil,
                                                       accountPerformanceTestData: nil,
                                                       allocationTestResponse: nil,
                                                       accountSummaryTest: nil,
                                                       pnlModelResponseTest: nil,
                                                       testTickleResponse: nil,
                                                       paSummaryResponse: nil,
                                                       iServerResponse: iServerResponse
        )
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        let accountViewModel = AccountViewModel(repository: accountRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: (IServerResponse?, NetworkError?) = (nil, nil)
        
        accountViewModel.getIServerAccount { response in
            result = response
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result.0 == nil)
        XCTAssertTrue(result.1 != nil)
        XCTAssertEqual(result.1, NetworkError.serverError)
    }
    
    func test_AccountViewModel_getIServerAccount_shouldReturnDecodeError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.decodeError)
        
        let accountApiService =  MockAccountApiService(accountTestData: nil,
                                                       accountPerformanceTestData: nil,
                                                       allocationTestResponse: nil,
                                                       accountSummaryTest: nil,
                                                       pnlModelResponseTest: nil,
                                                       testTickleResponse: nil,
                                                       paSummaryResponse: nil,
                                                       iServerResponse: iServerResponse
        )
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        let accountViewModel = AccountViewModel(repository: accountRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: (IServerResponse?, NetworkError?) = (nil, nil)
        
        accountViewModel.getIServerAccount { response in
            result = response
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result.0 == nil)
        XCTAssertTrue(result.1 != nil)
        XCTAssertEqual(result.1, NetworkError.decodeError)
    }
    
    func test_AccountViewModel_fetchAccount_shouldSetAccount() {
        let mockedAccount = MockedAccountModels.account
        
        let accountApiService =  MockAccountApiService(accountTestData: mockedAccount,
                                                       accountPerformanceTestData: nil,
                                                       allocationTestResponse: nil,
                                                       accountSummaryTest: nil,
                                                       pnlModelResponseTest: nil,
                                                       testTickleResponse: nil,
                                                       paSummaryResponse: nil,
                                                       iServerResponse: nil
        )
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        let accountViewModel = AccountViewModel(repository: accountRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        accountViewModel.$account
            .dropFirst()
            .sink { acc in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        accountViewModel.fetchAccount()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(accountViewModel.account != nil)
        XCTAssertEqual(accountViewModel.account?.id, mockedAccount[0].id)
        XCTAssertEqual(accountViewModel.account?.accountTitle, mockedAccount[0].accountTitle)
    }
    
    func test_AccountViewModel_fetchAccount_shouldSetAccountTotal() {
        let paSummaryResponse = MockedAccountModels.paSummaryResponse
        
        let accountApiService =  MockAccountApiService(accountTestData: nil,
                                                       accountPerformanceTestData: nil,
                                                       allocationTestResponse: nil,
                                                       accountSummaryTest: nil,
                                                       pnlModelResponseTest: nil,
                                                       testTickleResponse: nil,
                                                       paSummaryResponse: paSummaryResponse,
                                                       iServerResponse: nil
        )
        
        let accountRepository = AccountRepository(apiService: accountApiService)
        
        let accountViewModel = AccountViewModel(repository: accountRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        accountViewModel.$total
            .dropFirst()
            .sink { acc in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        accountViewModel.fetchAccount()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(accountViewModel.total != nil)
        XCTAssertEqual(accountViewModel.total?.rtn, paSummaryResponse.total?.rtn)
        XCTAssertEqual(accountViewModel.total?.chg, paSummaryResponse.total?.chg)
        XCTAssertEqual(accountViewModel.total?.startVal, paSummaryResponse.total?.startVal)
    }
    
}
