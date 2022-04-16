//
//  PortfolioRepository_tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 12.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class PortfolioRepository_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_PortfolioRepository_fetchPositions_shouldReturnPositions() {
        let mockedPositions = MockPortfolioModels.positions
        
        let portfolioApiService = MockPortfolioApiService(positions: mockedPositions)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        
        let portfolioRepository = PortfolioRepository(
            portfolioApiService: portfolioApiService,
            accountApiService: accountApiService,
            tickerApiService: tickerApiService
        )
        
            
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: [Position]? = nil
        
        portfolioRepository.fetchPositions{ response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, 11)
    }
    
    func test_PortfolioRepository_fetchPositions_shouldReturnEmptyArray() {
        let mockedPositions: [Position] = []
        
        let portfolioApiService = MockPortfolioApiService(positions: mockedPositions)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        
        let portfolioRepository = PortfolioRepository(
            portfolioApiService: portfolioApiService,
            accountApiService: accountApiService,
            tickerApiService: tickerApiService
        )
        
            
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: [Position]? = nil
        
        portfolioRepository.fetchPositions{ response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, 0)
    }
    
    func test_PortfolioRepository_fetchAccountAllocation_shouldReturnAllocationResponse() {
        let mockedAllocationResponse = MockedAccountModels.allocationResponse
        
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: mockedAllocationResponse,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil)
        
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        
        let portfolioRepository = PortfolioRepository(
            portfolioApiService: portfolioApiService,
            accountApiService: accountApiService,
            tickerApiService: tickerApiService
        )
        
            
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: AllocationResponse? = nil
        
        portfolioRepository.fetchAccountAllocation { response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.assetClass.long.count, mockedAllocationResponse.assetClass.long.count)
    }
    
    func test_PortfolioRepository_getAccountSummary_shouldReturnAccountSummary() {
        let mockedAccountSummary = MockedAccountModels.accountSumary
        
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: mockedAccountSummary,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil)
        
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        
        let portfolioRepository = PortfolioRepository(
            portfolioApiService: portfolioApiService,
            accountApiService: accountApiService,
            tickerApiService: tickerApiService
        )
        
            
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: AccountSummary? = nil
        
        portfolioRepository.getAccountSummary{ response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, mockedAccountSummary.count)
    }
    
    func test_PortfolioRepository_getPnL_shouldReturnCorePnlModel() {
        let mockedPnl = MockedAccountModels.pnlModelResponse
        
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: mockedPnl,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil)
        
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        
        let portfolioRepository = PortfolioRepository(
            portfolioApiService: portfolioApiService,
            accountApiService: accountApiService,
            tickerApiService: tickerApiService
        )
        
            
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        let expectedCorePnL = CorePnLModel(rowType: 1, dpl: -4.266, nl: 1025.0, upl: -1041.0, el: 171.7, mv: 861.6)
        
        var result: CorePnLModel? = nil
        
        portfolioRepository.getPnL { response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.rowType, expectedCorePnL.rowType)
        XCTAssertEqual(result?.dpl, expectedCorePnL.dpl)
        XCTAssertEqual(result?.nl, expectedCorePnL.nl)
        XCTAssertEqual(result?.upl, expectedCorePnL.upl)
        XCTAssertEqual(result?.el, expectedCorePnL.el)
        XCTAssertEqual(result?.mv, expectedCorePnL.mv)
    }

}
