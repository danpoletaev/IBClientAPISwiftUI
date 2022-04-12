//
//  HomeRepository_tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 11.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class HomeRepository_tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_HomeRepositoryTest_fetchTopPositions_shouldReturnSortedArray() {
        let mockedPositions = MockPortfolioModels.positions
        
        let sortedPositions = mockedPositions.sorted {
            $0.position ?? 0 > $1.position ?? 0
        }
        
        let homeApiService = MockHomeApiService(scannerResponse: nil)
        let portfolioApiService = MockPortfolioApiService(positions: mockedPositions)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        
        let homeRepository = HomeRepository(
            homeApiService: homeApiService,
            portfolioApiService: portfolioApiService,
            tickerApiService: tickerApiService,
            accountApiService: accountApiService
        )
        
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: [Position]? = nil
        
        homeRepository.fetchTopPositions { response in
            result = response
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result!.count, 3)
        for i in 0...2 {
            XCTAssertEqual(result![i].position, sortedPositions[i].position)
        }
    }
    
    func test_HomeRepositoryTest_fetchTopPositions_shouldReturnEmptyArray() {
        let mockedPositions: [Position] = []
        
        let homeApiService = MockHomeApiService(scannerResponse: nil)
        let portfolioApiService = MockPortfolioApiService(positions: mockedPositions)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        
        let homeRepository = HomeRepository(
            homeApiService: homeApiService,
            portfolioApiService: portfolioApiService,
            tickerApiService: tickerApiService,
            accountApiService: accountApiService
        )
        
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: [Position]? = nil
        
        homeRepository.fetchTopPositions { response in
            result = response
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result!.count, 0)
    }
    
    func test_HomeRepositoryTest_fetchAccountPerformance_shouldReturnAccountPerformance() {
        let mockedPerformanceResponse = MockedAccountModels.performanceResponse
        
        let mockedAccountPerformance = MockedAccountModels.mockedAccountPerformance
        
        let homeApiService = MockHomeApiService(scannerResponse: nil)
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: mockedPerformanceResponse, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        
        let homeRepository = HomeRepository(
            homeApiService: homeApiService,
            portfolioApiService: portfolioApiService,
            tickerApiService: tickerApiService,
            accountApiService: accountApiService
        )
        
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: AccountPerformance? = nil
        
        homeRepository.fetchAccountPerformance { (response, error) in
            result = response
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.dates.count, mockedAccountPerformance.dates.count)
        XCTAssertEqual(result?.graphData.count, mockedAccountPerformance.graphData.count)
    }
    
    func test_HomeRepositoryTest_fetchDailyGainers_shouldReturn5DailyGainers() {
        let mockedSecDefResponse = MockTickerModels.secDefResponse
        
        let homeApiService = MockHomeApiService(scannerResponse: nil)
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: mockedSecDefResponse, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        
        let homeRepository = HomeRepository(
            homeApiService: homeApiService,
            portfolioApiService: portfolioApiService,
            tickerApiService: tickerApiService,
            accountApiService: accountApiService
        )
        
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: [SecDefConid]? = nil

        homeRepository.fetchDailyGainers { (response, error) in
            result = response
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result!.count, 1)
    }
    
}
