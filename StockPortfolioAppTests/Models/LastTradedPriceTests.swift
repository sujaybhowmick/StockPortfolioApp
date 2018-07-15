//
//  LastTradedPriceTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 6/26/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest

@testable import StockPortfolioApp

class LastTradedPriceTests: XCTestCase {
    var mockJson: Data = """
        [
            {
                "symbol": "AAPL",
                "price": 184.94,
                "size": 100,
                "time": 1530024843588
            }
        ]
        """.data(using: .utf8)!
    
    func testValidateLastTradedPrice() throws {
        let lastTradedPrice = try JSONDecoder().decode([LastTradedPrice].self, from: self.mockJson)
        XCTAssertTrue(lastTradedPrice[0].symbol == "AAPL")
        XCTAssertTrue(lastTradedPrice[0].price == "184.94")
    }
}
