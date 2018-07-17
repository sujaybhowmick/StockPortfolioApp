//
//  KeyStatsTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 7/17/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest
@testable import StockPortfolioApp

class KeyStatsTests: XCTestCase {
    var mockJson: Data = """
        {"companyName":"Apple Inc.","marketcap":938348995580,"beta":1.157196,"week52high":194.2,"week52low":147.3,"week52change":30.084402,"shortInterest":38080068,"shortDate":"2018-06-29","dividendRate":2.92,"dividendYield":1.5295166,"exDividendDate":"2018-05-11 00:00:00.0","latestEPS":0,"latestEPSDate":"2017-09-30","sharesOutstanding":4915138000,"float":4905331314,"returnOnEquity":37.81,"consensusEPS":2.69,"numberOfEstimates":10,"EPSSurpriseDollar":null,"EPSSurprisePercent":1.487,"symbol":"AAPL","EBITDA":47576000000,"revenue":140872000000,"grossProfit":53843000000,"cash":151334000000,"debt":238080000000,"ttmEPS":10.36,"revenuePerShare":29,"revenuePerEmployee":1145301,"peRatioHigh":114.1,"peRatioLow":0,"returnOnAssets":14.13,"returnOnCapital":null,"profitMargin":22.08,"priceToSales":4.6553044,"priceToBook":7.43,"day200MovingAvg":173.0109,"day50MovingAvg":187.91118,"institutionPercent":54.2,"insiderPercent":null,"shortRatio":1.5091888,"year5ChangePercent":2.4022237152332866,"year2ChangePercent":0.9792710982461196,"year1ChangePercent":0.29632119377526805,"ytdChangePercent":0.11707621056573522,"month6ChangePercent":0.09215934737028783,"month3ChangePercent":0.09001300067886722,"month1ChangePercent":0.011497297870085766,"day5ChangePercent":0.0029419490412398333,"day30ChangePercent":-0.004795913048011343}
        """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKeyStats() throws {
        let keyStats = try JSONDecoder().decode(KeyStats.self, from: self.mockJson)
        XCTAssertTrue(keyStats.marketcap == 938348995580)
        
    }
}
