//
//  CharDataTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 6/23/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest
@testable import StockPortfolioApp

class ChartTests: XCTestCase {
    var mockJson: Data = """
    [{
        "date": "2018-05-21",
        "open": 188,
        "high": 189.27,
        "low": 186.9106,
        "close": 187.63,
        "volume": 18400787,
        "unadjustedVolume": 18400787,
        "change": 1.32,
        "changePercent": 0.708,
        "vwap": 188.0776,
        "label": "May 21",
        "changeOverTime": 0
    },
    {
        "date": "2018-05-22",
        "open": 188.375,
        "high": 188.88,
        "low": 186.78,
        "close": 187.16,
        "volume": 15240704,
        "unadjustedVolume": 15240704,
        "change": -0.47,
        "changePercent": -0.25,
        "vwap": 187.5847,
        "label": "May 22",
        "changeOverTime": -0.002504929915258748
    }
]
""".data(using: .utf8)!
    
    func testValidateCount() throws {
        let chart = try JSONDecoder().decode([Chart].self, from: self.mockJson)
        XCTAssertTrue(chart.count == 2)
    }
}
