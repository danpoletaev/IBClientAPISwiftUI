//
//  HomeApiService_Tests.swift
//  IBClientAPISwiftUITests
//
//  Created by Danil Poletaev on 08.04.2022.
//

import XCTest
@testable import IBClientAPISwiftUI

class HomeApiService_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeApiService_getScannerConids_shouldReturnItems() {
        
        let scannerResponse = MockedHomeModels.scannerResponse
        
        let homeApiService: HomeApiServiceProtocol = MockHomeApiService(scannerResponse: scannerResponse)
        
        homeApiService.getScannerConids { scannerResp in
            XCTAssertEqual(scannerResponse.Contracts.Contract.count, scannerResp.Contracts.Contract.count)
        }
    }

}
