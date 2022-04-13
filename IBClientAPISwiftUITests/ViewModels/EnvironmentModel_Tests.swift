//
//  EnvironmentViewModel_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 13.04.2022.
//

import XCTest
import Combine
@testable import IBClientAPISwiftUI

class EnvironmentViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_EnvironmentViewModel_getIServerAccount_shouldSetAuthorizedTrue() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (MockedAccountModels.iServerResponse, nil)
        
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
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
        let environmentViewModel = EnvironmentViewModel(accountViewModel: accountViewModel)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: Bool? = nil
        
        environmentViewModel.$authorized
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        environmentViewModel.getIServerAccount { value in }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertTrue(result!)
    }
    
    func test_EnvironmentViewModel_getIServerAccount_shouldSetAuthorizedFalseUnauthorizedError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.unauthorized)
        
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
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
        let environmentViewModel = EnvironmentViewModel(accountViewModel: accountViewModel)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: Bool? = nil
        
        environmentViewModel.$authorized
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        environmentViewModel.getIServerAccount { value in }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertFalse(result!)
    }
    
    func test_EnvironmentViewModel_getIServerAccount_shouldSetAuthorizedFalseDecodeError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.decodeError)
        
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
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
        let environmentViewModel = EnvironmentViewModel(accountViewModel: accountViewModel)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: Bool? = nil
        
        environmentViewModel.$authorized
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        environmentViewModel.getIServerAccount { value in }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertFalse(result!)
    }
    
    func test_EnvironmentViewModel_getIServerAccount_shouldSetAuthorizedFalseServerError() {
        let iServerResponse: (IServerResponse?, NetworkError?) = (nil, NetworkError.decodeError)
        
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
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
        let environmentViewModel = EnvironmentViewModel(accountViewModel: accountViewModel)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: Bool? = nil
        
        environmentViewModel.$authorized
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        environmentViewModel.getIServerAccount { value in }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertFalse(result!)
    }

    func test_EnvironmentViewModel_fetchData_shouldSetAccountInAccountViewModel() {
        let mockAccounts = MockedAccountModels.account
        
        let accountApiService = MockAccountApiService(
            accountTestData: mockAccounts,
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
        let environmentViewModel = EnvironmentViewModel(accountViewModel: accountViewModel)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: Account? = nil
        
        environmentViewModel.accountViewModel.$account
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        environmentViewModel.fetchData()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.id, mockAccounts[0].id)
        XCTAssertEqual(result?.accountId, mockAccounts[0].accountId)
        XCTAssertEqual(result?.accountTitle, mockAccounts[0].accountTitle)
        XCTAssertEqual(result?.accountVan, mockAccounts[0].accountVan)
        XCTAssertEqual(result?.clearingStatus, mockAccounts[0].clearingStatus)
        XCTAssertEqual(result?.currency, mockAccounts[0].currency)
    }
    

}
