//
//  HomeViewModel_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 12.04.2022.
//

import XCTest
import Combine
@testable import IBClientAPISwiftUI

class HomeViewModel_Tests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeViewModel_onAppear_shouldSetTopPortfolio() {
        let positions = MockPortfolioModels.positions
        
        let sortedPositions = positions.sorted {
            $0.position ?? 0 > $1.position ?? 0
        }

        let homeApiService = MockHomeApiService(scannerResponse: nil)
        let portfolioApiService = MockPortfolioApiService(positions: positions)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let homeRepository = HomeRepository(homeApiService: homeApiService, portfolioApiService: portfolioApiService, tickerApiService: tickerApiService, accountApiService: accountApiService)
        let homeVM = HomeViewModel(homeRepository: homeRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        homeVM.$topPortfolio
            .dropFirst()
            .sink { topPortfolios in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        homeVM.onAppear()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(homeVM.topPortfolio.count == 3)
        for i in 0...2 {
            XCTAssertEqual(homeVM.topPortfolio[i].position, sortedPositions[i].position)
        }
    }
    
    func test_HomeViewModel_onAppear_shouldNotUpdateTopPortfolio() {
        let positions = MockPortfolioModels.positions
        
        let sortedPositions = positions.sorted {
            $0.position ?? 0 > $1.position ?? 0
        }

        let homeApiService = MockHomeApiService(scannerResponse: nil)
        let portfolioApiService = MockPortfolioApiService(positions: positions)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let homeRepository = HomeRepository(homeApiService: homeApiService, portfolioApiService: portfolioApiService, tickerApiService: tickerApiService, accountApiService: accountApiService)
        let homeVM = HomeViewModel(homeRepository: homeRepository)
        
        for i in 0...5 {
            let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
            
            homeVM.$topPortfolio
                .dropFirst()
                .sink { topPortfolios in
                    if (i != 0) {
                        XCTFail()
                    }
                }
                .store(in: &cancellables)
            
            homeVM.onAppear()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                expectation.fulfill()
            })
            wait(for: [expectation], timeout: 2.5)
            XCTAssertTrue(homeVM.topPortfolio.count == 3)
            for i in 0...2 {
                XCTAssertEqual(homeVM.topPortfolio[i].position, sortedPositions[i].position)
            }
        }
    }
    
    func test_HomeViewModel_onAppear_shouldSetTopPortfolioToEmpty() {
        let positions: [Position] = []

        let homeApiService = MockHomeApiService(scannerResponse: nil)
        let portfolioApiService = MockPortfolioApiService(positions: positions)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let homeRepository = HomeRepository(homeApiService: homeApiService, portfolioApiService: portfolioApiService, tickerApiService: tickerApiService, accountApiService: accountApiService)
        let homeVM = HomeViewModel(homeRepository: homeRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        homeVM.$topPortfolio
            .dropFirst()
            .sink { topPortfolios in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        homeVM.onAppear()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(homeVM.topPortfolio.count == 0)
    }
    
    func test_HomeViewModel_onAppear_shouldSetDailyGainers() {
        let dailyGainersScanners = MockedHomeModels.scannerResponse

        let homeApiService = MockHomeApiService(scannerResponse: dailyGainersScanners)
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let homeRepository = HomeRepository(homeApiService: homeApiService, portfolioApiService: portfolioApiService, tickerApiService: tickerApiService, accountApiService: accountApiService)
        let homeVM = HomeViewModel(homeRepository: homeRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        homeVM.$secDefConids
            .dropFirst()
            .sink { secDefConids in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        XCTAssertEqual(homeVM.secDefConids.count, 0)
        
        homeVM.onAppear()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(homeVM.secDefConids.count, 1)
    }
    
    func test_HomeViewModel_onAppear_shouldNotUpdateDailyGainers() {
        let dailyGainersScanners = MockedHomeModels.scannerResponse

        let homeApiService = MockHomeApiService(scannerResponse: dailyGainersScanners)
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let homeRepository = HomeRepository(homeApiService: homeApiService, portfolioApiService: portfolioApiService, tickerApiService: tickerApiService, accountApiService: accountApiService)
        let homeVM = HomeViewModel(homeRepository: homeRepository)
        
        for i in 0...5 {
            let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
            
            homeVM.$topPortfolio
                .dropFirst()
                .sink { topPortfolios in
                    if (i != 0) {
                        XCTFail()
                    }
                }
                .store(in: &cancellables)
            
            homeVM.onAppear()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                expectation.fulfill()
            })
            wait(for: [expectation], timeout: 2.5)
        }
    }
    
    func test_HomeViewModel_onAppear_shouldSetAccountPerformance() {
        let accountPerfromance = MockedAccountModels.performanceResponse
        let formattedAccountPerformance = MockedAccountModels.mockedAccountPerformance

        let homeApiService = MockHomeApiService(scannerResponse: nil)
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: accountPerfromance, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let homeRepository = HomeRepository(homeApiService: homeApiService, portfolioApiService: portfolioApiService, tickerApiService: tickerApiService, accountApiService: accountApiService)
        let homeVM = HomeViewModel(homeRepository: homeRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        homeVM.$accountPerformance
            .dropFirst()
            .sink { accPerformance in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        homeVM.onAppear()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(homeVM.accountPerformance.dates.count, formattedAccountPerformance.dates.count)
        XCTAssertEqual(homeVM.accountPerformance.graphData.count, formattedAccountPerformance.graphData.count)
    }
    
    
    func test_HomeViewModel_onAppear_shouldIsLoadingToTrue() {
        
        let homeApiService = MockHomeApiService(scannerResponse: nil)
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let accountApiService = MockAccountApiService(accountTestData: nil, accountPerformanceTestData: nil, allocationTestResponse: nil, accountSummaryTest: nil, pnlModelResponseTest: nil, testTickleResponse: nil, paSummaryResponse: nil, iServerResponse: nil)
        
        let homeRepository = HomeRepository(homeApiService: homeApiService, portfolioApiService: portfolioApiService, tickerApiService: tickerApiService, accountApiService: accountApiService)
        
        for _ in 0...5 {
            let homeVM = HomeViewModel(homeRepository: homeRepository)
            
            let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
            
            homeVM.$isLoading
                .dropFirst()
                .sink { isLoading in
                    expectation.fulfill()
                }
                .store(in: &cancellables)
            
            homeVM.onAppear()
            
            wait(for: [expectation], timeout: 5)
            XCTAssertFalse(homeVM.isLoading)
        }
    }
    

}
