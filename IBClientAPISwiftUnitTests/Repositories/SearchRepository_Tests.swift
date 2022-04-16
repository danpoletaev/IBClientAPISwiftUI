//
//  SearchRepository_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 12.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class SearchRepository_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SearchRepository_searchForNameSymbol_shouldReturnTickerArray() {
        let mockedSearchTicket = MockSeachModels.searchTickets
        
        let searchApiService = MockSearchApiService(searchTicket: mockedSearchTicket)
        let searchRepository = SearchRepository(apiService: searchApiService)
        
        let expectation = XCTestExpectation(description: "Should return data after 0.5 seconds")
        
        var result: [SearchTicket]? = nil
        
        searchRepository.searchForNameSymbol(value: "APP") { response in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, mockedSearchTicket.count)
    }
}
