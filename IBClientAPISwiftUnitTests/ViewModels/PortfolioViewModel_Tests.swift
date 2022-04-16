//
//  PortfolioViewModel_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 13.04.2022.
//

import XCTest
import Combine
@testable import IBClientAPISwiftUI

class PortfolioViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_PortfolioViewModel_onAppear_shouldSetPositions() {
        let mockPosititions = MockPortfolioModels.positions
        
        let portfolioApiService = MockPortfolioApiService(positions: mockPosititions)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil
        )
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let portfolioRepository = PortfolioRepository(portfolioApiService: portfolioApiService, accountApiService: accountApiService, tickerApiService: tickerApiService)
        let portfolioViewModel = PortfolioViewModel(repository: portfolioRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: [Position]? = nil
        
        portfolioViewModel.$positions
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        portfolioViewModel.onAppear()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(mockPosititions.count, result?.count)
    }
    
    func test_PortfolioViewModel_onAppear_shouldSetPositionsToEmpty() {
        let mockPosititions: [Position] = []
        
        let portfolioApiService = MockPortfolioApiService(positions: mockPosititions)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil
        )
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let portfolioRepository = PortfolioRepository(portfolioApiService: portfolioApiService, accountApiService: accountApiService, tickerApiService: tickerApiService)
        let portfolioViewModel = PortfolioViewModel(repository: portfolioRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: [Position]? = nil
        
        portfolioViewModel.$positions
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        portfolioViewModel.onAppear()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, 0)
    }
    
    func test_HomeViewModel_onAppear_shouldNotUpdatePositions() {
        let mockPosititions = MockPortfolioModels.positions
        
        let portfolioApiService = MockPortfolioApiService(positions: mockPosititions)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil
        )
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let portfolioRepository = PortfolioRepository(portfolioApiService: portfolioApiService, accountApiService: accountApiService, tickerApiService: tickerApiService)
        let portfolioViewModel = PortfolioViewModel(repository: portfolioRepository)
        
        for i in 0...5 {
            let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
            
            portfolioViewModel.$positions
                .dropFirst()
                .sink { topPortfolios in
                    if (i != 0) {
                        XCTFail()
                    }
                }
                .store(in: &cancellables)
            
            portfolioViewModel.onAppear()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                expectation.fulfill()
            })
            wait(for: [expectation], timeout: 2.5)
        }
    }
    
    func test_PortfolioViewModel_onAppear_shouldSetAssetClass() {
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
            iServerResponse: nil
        )
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let portfolioRepository = PortfolioRepository(portfolioApiService: portfolioApiService, accountApiService: accountApiService, tickerApiService: tickerApiService)
        let portfolioViewModel = PortfolioViewModel(repository: portfolioRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: AssetClass? = nil
        
        portfolioViewModel.$assetClass
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        portfolioViewModel.onAppear()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.long.count, mockedAllocationResponse.assetClass.long.count)
        XCTAssertEqual(result?.short.count, mockedAllocationResponse.assetClass.short.count)
    }
    
    func test_PortfolioViewModel_onAppear_shouldSetAccountSummary() {
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
            iServerResponse: nil
        )
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let portfolioRepository = PortfolioRepository(portfolioApiService: portfolioApiService, accountApiService: accountApiService, tickerApiService: tickerApiService)
        let portfolioViewModel = PortfolioViewModel(repository: portfolioRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: AccountSummary? = nil
        
        portfolioViewModel.$accountSummary
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        portfolioViewModel.onAppear()
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, mockedAccountSummary.count)
    }
    
    func test_PortfolioViewModel_onAppear_shouldSetDailyPnL() {
        let mockedPnlResponse = MockedAccountModels.pnlModelResponse
        
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: mockedPnlResponse,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil
        )
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let portfolioRepository = PortfolioRepository(portfolioApiService: portfolioApiService, accountApiService: accountApiService, tickerApiService: tickerApiService)
        let portfolioViewModel = PortfolioViewModel(repository: portfolioRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: CorePnLModel? = nil
        
        portfolioViewModel.$dailyPnL
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        portfolioViewModel.onAppear()
        
        
        var expectedCorePnl: CorePnLModel? = nil
        
        if let pnl = mockedPnlResponse.upnl.first {
            expectedCorePnl = pnl.value
        }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertTrue(expectedCorePnl != nil)
        XCTAssertEqual(result?.dpl, expectedCorePnl?.dpl)
        XCTAssertEqual(result?.el, expectedCorePnl?.el)
        XCTAssertEqual(result?.mv, expectedCorePnl?.mv)
        XCTAssertEqual(result?.nl, expectedCorePnl?.nl)
        XCTAssertEqual(result?.upl, expectedCorePnl?.upl)
    }
    
    func test_HomeViewModel_onAppear_shouldIsLoadingToTrue() {
        
        let portfolioApiService = MockPortfolioApiService(positions: nil)
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil
        )
        let tickerApiService = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: nil)
        let portfolioRepository = PortfolioRepository(portfolioApiService: portfolioApiService, accountApiService: accountApiService, tickerApiService: tickerApiService)
        
        for _ in 0...5 {
            let portfolioViewModel = PortfolioViewModel(repository: portfolioRepository)
            
            let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
            
            portfolioViewModel.$isLoading
                .dropFirst()
                .sink { isLoading in
                    expectation.fulfill()
                }
                .store(in: &cancellables)
            
            portfolioViewModel.onAppear()
            
            wait(for: [expectation], timeout: 5)
            XCTAssertFalse(portfolioViewModel.isLoading)
        }
    }
    

}
