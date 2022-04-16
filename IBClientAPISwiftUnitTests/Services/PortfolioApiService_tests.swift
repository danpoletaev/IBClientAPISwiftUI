//
//  PortfolioApiService_tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 09.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class PortfolioApiService_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_PortfolioApiServicee_fetchPositions_shouldReturnItems() {
        let positions: [Position] = MockPortfolioModels.positions
        
        let portfolioApiService: PortfolioApiServiceProtocol = MockPortfolioApiService(positions: positions)
        
            
        portfolioApiService.fetchPositions(accountID: "1") { response in
            XCTAssertEqual(response.count, positions.count)
        }
    }
}
