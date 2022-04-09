//
//  TickerApiService_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 08.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class TickerApiService_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // just send back the first one, which ought to be the only one
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TickerApiService_getTickerInfo_shouldReturnItems() {
        
        let tickerInfo = MockTickerModels.tickerInfo
        
        let tickerApiService: TickerApiServiceProtocol = MockTickerApiService(tickerInfo: tickerInfo, secDefResponse: nil, historyConidResponse: nil)

        tickerApiService.getTickerInfo(conid: 1) { tickerInfos in
            XCTAssertEqual(tickerInfo.conid, tickerInfos[0].conid)
        }

    }
    
    func test_TickerApiService_getSecDefByConids_shouldReturnItems() {
        
        let secDefResponse = MockTickerModels.secDefResponse
        
        let tickerApiService: TickerApiServiceProtocol = MockTickerApiService(tickerInfo: nil, secDefResponse: secDefResponse, historyConidResponse: nil)

        tickerApiService.getSecDefByConids(value: [1]) { secDef in
            XCTAssertEqual(secDef.secdef.count, secDefResponse.secdef.count)
        }
    }
    
    func test_TickerApiService_getHistoryConidResponse_shouldReturnItems() {
        
        let historyConidResponse = MockTickerModels.historyConidResponse
        
        let tickerApiService: TickerApiServiceProtocol = MockTickerApiService(tickerInfo: nil, secDefResponse: nil, historyConidResponse: historyConidResponse)
        
        tickerApiService.getConidHistory(conid: 1, period: "Q") { response in
            XCTAssertEqual(response.data.count, historyConidResponse.data.count)
        }
    }

}
