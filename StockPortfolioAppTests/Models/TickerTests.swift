//
//  TickerTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 7/14/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest
@testable import StockPortfolioApp

class TickerTests: XCTestCase {
    var mockJson: Data = """
        [
            {
                "symbol": "A",
                "name": "Agilent Technologies Inc.",
                "date": "2018-07-11",
                "isEnabled": true,
                "type": "cs",
                "iexId": "2"
            },
            {
                "symbol": "AA",
                "name": "Alcoa Corporation",
                "date": "2018-07-11",
                "isEnabled": true,
                "type": "cs",
                "iexId": "12042"
            }
        ]
        """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTickers() throws {
        let tickers = try JSONDecoder().decode([Ticker].self, from: self.mockJson)
        XCTAssertTrue(tickers.count == 2)
        print(tickers)
    }
}
