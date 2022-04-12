//
//  TicketRepository_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 12.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class TicketRepository_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TicketRepository_getTickerInfo_shouldReturnTickerInfo() {
        let mockedTickerInfo = MockTickerModels.tickerInfo
        
        let ticketApiService = MockTickerApiService(
            tickerInfo: mockedTickerInfo,
            secDefResponse: nil,
            historyConidResponse: nil)
        
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil)
        
        let ticketRepository = TicketRepository(apiService: ticketApiService, acccountApiService: accountApiService)
        
            
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        
        var result: TickerInfo? = nil
        
        ticketRepository.getTickerInfo(conid: 1) { response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.positions, mockedTickerInfo.positions)
        XCTAssertEqual(result?.bid, mockedTickerInfo.bid)
        XCTAssertEqual(result?.avgDailyVolume, mockedTickerInfo.avgDailyVolume)
    }
    
    
    
    func test_TicketRepository_getConidHistory_shouldReturnAccountPerformance() {
        let historyConidResponse = MockTickerModels.historyConidResponse
        
        let ticketApiService = MockTickerApiService(
            tickerInfo: nil,
            secDefResponse: nil,
            historyConidResponse: historyConidResponse)
        
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: nil,
            paSummaryResponse: nil,
            iServerResponse: nil)
        
        let ticketRepository = TicketRepository(apiService: ticketApiService, acccountApiService: accountApiService)
        
            
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        let expectedAccountPerformance: AccountPerformance = AccountPerformance(graphData: [10.65, 10.65, 10.65, 10.65, 10.65, 10.65, 10.65, 10.65, 10.65, 10.65, 10.65, 10.65, 10.65, 14.16, 14.16, 14.16, 20.95, 20.95, 20.95, 20.95, 20.95, 20.95, 20.95, 20.95, 20.95, 20.95, 20.95, 20.95, 20.95, 70.85, 41.35, 66.02, 61.55, 79.5, 68.6, 60.55, 58.5, 51.5, 49.0, 46.11, 44.45, 35.5, 23.83, 20.03, 19.5, 19.3, 18.35, 18.11, 17.11, 16.88, 16.64, 16.42, 15.61, 14.59, 13.72, 12.55, 12.69, 12.42, 12.5, 12.2, 11.91, 12.1, 12.03, 12.08, 11.96, 12.04, 11.86, 11.98, 12.93, 12.75, 12.99, 12.78, 12.74, 12.48, 12.33, 12.34, 12.35, 12.38, 12.36, 12.59, 12.2, 11.3, 11.2, 11.47, 11.45, 11.64, 11.9, 11.8, 11.77, 11.58, 11.84, 11.77, 11.79, 11.72, 12.16, 12.15, 12.06, 11.94, 11.88, 11.91, 11.82, 12.01, 12.1, 12.24, 12.16, 12.32, 12.0, 11.28, 11.4, 11.26, 10.91, 11.0, 10.99, 10.89, 10.86, 10.86, 10.92, 11.13, 11.11, 11.12, 10.62, 10.75, 10.4, 10.28, 10.06, 10.13, 10.14, 10.26, 10.43, 10.27, 10.4, 10.49, 10.33, 9.54, 9.54, 9.61, 9.44, 9.54, 9.49, 9.4, 9.45, 9.45, 9.53, 9.53, 9.55, 9.51, 9.75, 9.56, 9.62, 9.47, 9.43, 9.36, 9.35, 9.36, 9.36, 9.45, 9.47, 9.38, 9.35, 9.38, 9.27, 9.28, 9.18, 9.13, 8.99, 8.88, 8.96, 8.93, 8.95, 9.16, 9.0, 9.16, 8.92, 8.76, 8.8, 8.92, 8.87, 8.82, 8.83, 8.87, 8.88, 8.87, 8.86, 8.76, 8.96, 8.97, 8.99, 9.05, 9.32, 9.16, 9.28, 9.22, 9.32, 9.1, 9.13, 9.12, 9.16, 9.14, 9.16, 9.13, 9.13, 9.02, 9.01, 8.95, 9.0, 8.92, 8.91, 8.95, 8.99, 9.33, 9.12, 9.15, 8.84, 8.79, 8.78, 8.75, 8.71, 8.73, 8.81, 8.88, 8.95, 8.93, 8.86, 8.92, 8.88, 8.84, 8.69, 8.51, 8.46, 8.54, 8.51, 8.51, 8.54, 8.46, 8.53, 8.47, 8.45, 8.25, 8.37, 8.4, 8.59, 8.59, 8.59, 8.51], dates: ["58-11-25", "58-12-16", "59-01-05", "59-01-26", "59-02-16", "59-03-09", "59-03-30", "59-04-20", "59-05-10", "59-05-31", "59-06-21", "59-07-12", "59-08-02", "62-03-17", "62-04-07", "62-04-28", "69-09-26", "69-10-17", "69-11-07", "69-11-28", "69-12-18", "70-01-08", "70-01-29", "70-02-19", "70-03-12", "70-04-02", "70-04-22", "70-05-13", "70-06-03", "72-06-22", "72-07-13", "72-08-03", "72-08-24", "72-09-13", "72-10-04", "72-10-25", "72-11-15", "72-12-06", "72-12-27", "73-01-16", "73-02-06", "73-02-27", "75-03-19", "75-04-09", "75-04-30", "75-05-21", "75-06-10", "75-07-01", "75-07-22", "75-08-12", "75-09-02", "75-09-23", "75-10-13", "75-11-03", "75-11-24", "77-12-13", "78-01-03", "78-01-24", "78-02-14", "78-03-06", "78-03-27", "78-04-17", "78-05-08", "78-05-29", "78-06-19", "78-07-09", "78-07-30", "78-08-20", "80-09-08", "80-09-29", "80-10-20", "80-11-10", "80-11-30", "80-12-21", "81-01-11", "81-02-01", "81-02-22", "81-03-15", "81-04-04", "81-04-25", "81-05-16", "88-11-25", "88-12-16", "89-01-06", "89-01-27", "89-02-16", "89-03-09", "89-03-30", "89-04-20", "89-05-11", "89-06-01", "89-06-21", "89-07-12", "89-08-02", "97-02-11", "97-03-04", "97-03-25", "97-04-15", "97-05-05", "97-05-26", "97-06-16", "97-07-07", "97-07-28", "97-08-18", "97-09-07", "97-09-28", "97-10-19", "99-11-08", "99-11-29", "99-12-20", "00-01-10", "00-01-30", "00-02-20", "00-03-13", "00-04-03", "00-04-24", "00-05-15", "00-06-04", "00-06-25", "00-07-16", "08-01-26", "08-02-16", "08-03-08", "08-03-29", "08-04-18", "08-05-09", "08-05-30", "08-06-20", "08-07-11", "08-08-01", "08-08-21", "08-09-11", "08-10-02", "10-10-22", "10-11-12", "10-12-03", "10-12-24", "11-01-13", "11-02-03", "11-02-24", "11-03-17", "11-04-07", "11-04-28", "11-05-18", "11-06-08", "11-06-29", "13-07-18", "13-08-08", "13-08-29", "13-09-19", "13-10-09", "13-10-30", "13-11-20", "13-12-11", "14-01-01", "14-01-22", "14-02-11", "14-03-04", "14-03-25", "16-04-13", "16-05-04", "16-05-25", "16-06-15", "16-07-05", "16-07-26", "16-08-16", "16-09-06", "16-09-27", "16-10-18", "16-11-07", "16-11-28", "16-12-19", "19-01-08", "19-01-29", "19-02-19", "19-03-12", "19-04-01", "19-04-22", "19-05-13", "19-06-03", "19-06-24", "19-07-15", "19-08-04", "19-08-25", "19-09-15", "27-03-27", "27-04-17", "27-05-08", "27-05-29", "27-06-18", "27-07-09", "27-07-30", "27-08-20", "27-09-10", "27-10-01", "27-10-21", "27-11-11", "27-12-02", "29-12-21", "30-01-11", "30-02-01", "30-02-22", "30-03-14", "30-04-04", "30-04-25", "30-05-16", "30-06-06", "30-06-27", "30-07-17", "30-08-07", "30-08-28", "32-09-16", "32-10-07", "32-10-28", "32-11-18", "32-12-08", "32-12-29", "33-01-19", "33-02-09", "33-03-02", "33-03-23", "33-04-12", "33-05-03", "33-05-24", "35-06-13", "35-07-04", "35-07-25", "35-08-15", "35-09-04", "35-09-25", "35-10-16", "35-11-06", "35-11-27", "35-12-18", "36-01-07", "36-01-28", "36-02-18", "38-04-20", "38-05-11", "38-05-31", "38-06-21", "38-07-12", "38-08-02", "38-08-23"], moneyChange: nil, percentChange: nil)
        
        var result: AccountPerformance? = nil
        
        ticketRepository.getConidHistory(conid: 1, period: "Q") { response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.graphData.count, expectedAccountPerformance.graphData.count)
        XCTAssertEqual(result?.dates.count, expectedAccountPerformance.dates.count)
    }
    
    
    
    func test_TicketRepository_tickle_shouldTickleResponse() {
        let mockedTickleResponse = MockedAccountModels.tickleResponse
        
        let ticketApiService = MockTickerApiService(
            tickerInfo: nil,
            secDefResponse: nil,
            historyConidResponse: nil)
        
        let accountApiService = MockAccountApiService(
            accountTestData: nil,
            accountPerformanceTestData: nil,
            allocationTestResponse: nil,
            accountSummaryTest: nil,
            pnlModelResponseTest: nil,
            testTickleResponse: mockedTickleResponse,
            paSummaryResponse: nil,
            iServerResponse: nil)
        
        let ticketRepository = TicketRepository(apiService: ticketApiService, acccountApiService: accountApiService)
            
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: TickleResponse? = nil
        
        ticketRepository.tickle{ response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.session, mockedTickleResponse.session)
    }

}
