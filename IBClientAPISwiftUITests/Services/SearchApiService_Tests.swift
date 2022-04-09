//
//  SearchApiService_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 09.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class SearchApiService_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SearchApiService_searchForNameSymbol_shouldReturnItems() {
        
        let searchTicketsResponse = MockSeachModels.searchTickets
        
        let searchApiService: SearchApiServiceProtocol = MockSearchApiService(searchTicket: searchTicketsResponse)
        
        searchApiService.searchForNameSymbol(value: "APP") { response in
            XCTAssertEqual(searchTicketsResponse.count, response.count)
        }
    }

}
