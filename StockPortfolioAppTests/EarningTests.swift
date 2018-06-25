//
//  EarningsTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 6/24/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest
@testable import StockPortfolioApp

class EarningTest: XCTestCase {
    var mockJson: Data = """
        {
        "symbol": "QCOM",
        "earnings": [{
                "actualEPS": 0.67,
                "consensusEPS": 0.55,
                "estimatedEPS": 0.55,
                "announceTime": "AMC",
                "numberOfEstimates": 6,
                "EPSSurpriseDollar": 0.12,
                "EPSReportDate": "2018-04-25",
                "fiscalPeriod": "Q2 2018",
                "fiscalEndDate": "2018-03-31",
                "yearAgo": 1.2,
                "yearAgoChangePercent": -0.4416666666666666,
                "estimatedChangePercent": -0.5416666666666666,
                "symbolId": 5736
            },
            {
                "actualEPS": 0.85,
                "consensusEPS": 0.77,
                "estimatedEPS": 0.77,
                "announceTime": "AMC",
                "numberOfEstimates": 6,
                "EPSSurpriseDollar": 0.08,
                "EPSReportDate": "2018-01-31",
                "fiscalPeriod": "Q1 2018",
                "fiscalEndDate": "2017-12-31",
                "yearAgo": 1.06,
                "yearAgoChangePercent": -0.19811320754716988,
                "estimatedChangePercent": -0.27358490566037735,
                "symbolId": 5736
            },
            {
                "actualEPS": 0.82,
                "consensusEPS": 0.7,
                "estimatedEPS": 0.7,
                "announceTime": "AMC",
                "numberOfEstimates": 7,
                "EPSSurpriseDollar": 0.12,
                "EPSReportDate": "2017-11-01",
                "fiscalPeriod": "Q4 2017",
                "fiscalEndDate": "2017-09-30",
                "yearAgo": 1.17,
                "yearAgoChangePercent": -0.29914529914529914,
                "estimatedChangePercent": -0.4017094017094017,
                "symbolId": 5736
            }]
        }
""".data(using: .utf8)!
    
    func testValidateCount() throws {
        let earning = try JSONDecoder().decode(Earning.self, from: self.mockJson)
        XCTAssertTrue(earning.earnings.count == 3)
    }
    
}
