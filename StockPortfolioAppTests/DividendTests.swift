//
//  DividendTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 6/24/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest

@testable import StockPortfolioApp

class DividendTests: XCTestCase {
    var mockJson: Data = """
     [
         {
             "exDate": "2018-02-09",
             "paymentDate": "2018-02-15",
             "recordDate": "2018-02-12",
             "declaredDate": "2018-02-01",
             "amount": 0.63,
             "flag": "",
             "type": "Dividend income",
             "qualified": "Q",
             "indicated": ""
         },
         {
             "exDate": "2017-11-10",
             "paymentDate": "2017-11-16",
             "recordDate": "2017-11-13",
             "declaredDate": "2017-11-02",
             "amount": 0.63,
             "flag": "",
             "type": "Dividend income",
             "qualified": "Q",
             "indicated": ""
         }
    ]
    """.data(using: .utf8)!
    
    func testValidateCount() throws {
        let dividends = try JSONDecoder().decode([Dividend].self, from: self.mockJson)
        XCTAssertTrue(dividends.count == 2)
    }
}
