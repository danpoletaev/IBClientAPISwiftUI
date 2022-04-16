//
//  SearchViewModel_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 13.04.2022.
//

import XCTest
import Combine
@testable import IBClientAPISwiftUI

class SearchViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_SearchViewModel_searchForNameSymbol_shouldSetTickets() {
        let searchTickets = MockSeachModels.searchTickets
        
        let searchApiService = MockSearchApiService(searchTicket: searchTickets)
        let searchRepository = SearchRepository(apiService: searchApiService)
        let searchViewModel = SearchViewModel(repository: searchRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: [SearchTicket]? = nil
        
        searchViewModel.$tickets
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        searchViewModel.searchForNameSymbol(value: "")
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, searchTickets.count)
    }
    
    func test_SearchViewModel_searchForNameSymbol_shouldSetEmptyTickets() {
        let searchTickets: [SearchTicket] = []
        
        let searchApiService = MockSearchApiService(searchTicket: searchTickets)
        let searchRepository = SearchRepository(apiService: searchApiService)
        let searchViewModel = SearchViewModel(repository: searchRepository)
        
        let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
        
        var result: [SearchTicket]? = nil
        
        searchViewModel.$tickets
            .dropFirst()
            .sink { recievedValue in
                result = recievedValue
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        searchViewModel.searchForNameSymbol(value: "")
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(result != nil)
        XCTAssertEqual(result?.count, 0)
    }
    
    func test_SearchViewModel_searchForName_shouldSetIsLoadingTrueFalse() {
        let searchTickets: [SearchTicket] = MockSeachModels.searchTickets
        
        let searchApiService = MockSearchApiService(searchTicket: searchTickets)
        let searchRepository = SearchRepository(apiService: searchApiService)
        
        for _ in 0...5 {
            let searchViewModel = SearchViewModel(repository: searchRepository)
            
            let expectation = XCTestExpectation(description: "Should return response after 0.5~1 seconds")
            
            searchViewModel.$isLoading
                .dropFirst()
                .sink { isLoading in
                    if (!isLoading) {
                        expectation.fulfill()
                    }
                }
                .store(in: &cancellables)
            
            searchViewModel.searchForNameSymbol(value: "")
            XCTAssertTrue(searchViewModel.isLoading)
            
            wait(for: [expectation], timeout: 5)
            XCTAssertFalse(searchViewModel.isLoading)
        }
    }

}
