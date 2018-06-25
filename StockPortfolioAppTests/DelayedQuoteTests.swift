//
//  DelayedQuoteTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 6/23/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest
@testable import StockPortfolioApp

class DelayedQuoteTests: XCTestCase {
    var mockJson: Data = """
        {
            "symbol": "AAPL",
            "delayedPrice": 184.92,
            "high": 186.15,
            "low": 184.7,
            "delayedSize": 6533230,
            "delayedPriceTime": 1529697600451,
            "processedTime": 1529698501932
        }
        """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidateSymbol() throws {
        let delayedQuote = try JSONDecoder().decode(DelayedQuote.self, from: self.mockJson)
        XCTAssertTrue(delayedQuote.symbol == "AAPL")
        XCTAssertFalse(delayedQuote.symbol == "MSFT")
    }
    
}
