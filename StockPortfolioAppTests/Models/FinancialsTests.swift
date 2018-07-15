//
//  FinancialsTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 6/25/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest

@testable import StockPortfolioApp

class FinancialsTests: XCTestCase {
    var mockJson: Data = """
    {
      "symbol": "AAPL",
      "financials": [
        {
          "reportDate": "2018-03-31",
          "grossProfit": 23422000000,
          "costOfRevenue": 37715000000,
          "operatingRevenue": 61137000000,
          "totalRevenue": 61137000000,
          "operatingIncome": 15894000000,
          "netIncome": 13822000000,
          "researchAndDevelopment": 3378000000,
          "operatingExpense": 7528000000,
          "currentAssets": 130053000000,
          "totalAssets": 367502000000,
          "totalLiabilities": null,
          "currentCash": 45059000000,
          "currentDebt": 20478000000,
          "totalCash": 87940000000,
          "totalDebt": 121840000000,
          "shareholderEquity": 126878000000,
          "cashChange": 17568000000,
          "cashFlow": 15130000000,
          "operatingGainsLosses": null
        },
        {
          "reportDate": "2017-12-31",
          "grossProfit": 33912000000,
          "costOfRevenue": 54381000000,
          "operatingRevenue": 88293000000,
          "totalRevenue": 88293000000,
          "operatingIncome": 26274000000,
          "netIncome": 20065000000,
          "researchAndDevelopment": 3407000000,
          "operatingExpense": 7638000000,
          "currentAssets": 143810000000,
          "totalAssets": 406794000000,
          "totalLiabilities": null,
          "currentCash": 27491000000,
          "currentDebt": 18478000000,
          "totalCash": 77153000000,
          "totalDebt": 122400000000,
          "shareholderEquity": 140199000000,
          "cashChange": 7202000000,
          "cashFlow": 28293000000,
          "operatingGainsLosses": null
        }
      ]
    }
    """.data(using: .utf8)!
    
    func testValidateCount() throws {
        let financials = try JSONDecoder().decode(Financials.self, from: self.mockJson)
        XCTAssertTrue(financials.financials.count == 2)
    }
}
